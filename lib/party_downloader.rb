# encoding: UTF-8
require 'rubygems'
require 'open-uri'
require 'hpricot'
require 'uri'

module PartyDownloader

  def self.set_wikipedia_url
    urls = {
      "ACT" => "http://en.wikipedia.org/wiki/ACT_New_Zealand",
      "Green" => "http://en.wikipedia.org/wiki/Green_Party_of_Aotearoa_New_Zealand",
      "Labour" => "http://en.wikipedia.org/wiki/New_Zealand_Labour_Party",
      "Maori Party" => "http://en.wikipedia.org/wiki/Māori_Party",
      "National" => "http://en.wikipedia.org/wiki/New_Zealand_National_Party",
      "NZ First" => "http://en.wikipedia.org/wiki/New_Zealand_First",
      "Progressive" => "http://en.wikipedia.org/wiki/New_Zealand_Progressive_Party",
      "United Future" => "http://en.wikipedia.org/wiki/United_Future_New_Zealand",
      "Aotearoa Legalise Cannabis" => "http://en.wikipedia.org/wiki/Aotearoa_Legalise_Cannabis_Party",
      "Direct Democracy Party" => "http://en.wikipedia.org/wiki/Direct_Democracy_Party_of_New_Zealand",
      "Libertarianz" => "http://en.wikipedia.org/wiki/Libertarianz",
      "New World Order" => "http://en.wikipedia.org/wiki/New_World_Order_Party",
      "NZ Pacific Party" => "http://en.wikipedia.org/wiki/New_Zealand_Pacific_Party",
      "Residents Action Movement" => "http://en.wikipedia.org/wiki/Residents_Action_Movement",
      "Alliance" => "http://en.wikipedia.org/wiki/Alliance_(New_Zealand_political_party)",
      "Bill and Ben Party" => "http://en.wikipedia.org/wiki/Bill_and_Ben_Party",
      "Family Party" => "http://en.wikipedia.org/wiki/Family_Party",
      "Kiwi Party" => "http://en.wikipedia.org/wiki/The_Kiwi_Party",
      "Democrats for social credit" => "http://en.wikipedia.org/wiki/New_Zealand_Democratic_Party",
      "Republic of NZ Party" => "http://en.wikipedia.org/wiki/The_Republic_of_New_Zealand_Party",
      "Workers Party" => "http://en.wikipedia.org/wiki/Workers_Party_of_New_Zealand"
    }
    urls.each do |party, url|
      party = Party.find_by_short(party)
      party.wikipedia_url = url
      party.save
    end
  end

  def self.response host, path
    resp = nil
    Net::HTTP.start(host) do |http|
      resp = http.get(path,
          {
            "Host" => host,
            "User-Agent" => "Mozilla/5.0 (Windows; U; Windows NT 5.1; rv:1.7.3) Gecko/20040913 Firefox/0.10.1",
            "Accept" => "text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5",
            "Accept-Language" => 'en-us,en;q=0.7,en-gb;q=0.3',
            "Accept-Encoding" => 'gzip,deflate',
            "Accept-Charset" => 'ISO-8859-1,utf-8;q=0.7,*;q=0.7'
      })
    end
    resp
  end

  def self.add_new_parties
    doc = Hpricot open('http://www.elections.org.nz/parties-candidates/registered-political-parties-0/register-political-parties')

    new_parties = (doc/'li.party-bio-content').collect do |p|
      party = PartyProxy.new
      title = p.at('h2 a')

      next unless title

      party.registered_name = title.inner_text
      uri = URI(p.at('.party-logo img')[:src])
      uri.query = nil
      party.logo = uri.to_s
      party.url = p.at('h2 a')[:href]
      party.abbreviation = p.at('.party-left-col p:nth(1)').inner_text
      party.abbreviation = party.registered_name if party.abbreviation.blank?
      party.vote_name = party.abbreviation

      unless party.logo.blank?
        party.logo_file = party.abbreviation.parameterize + File.extname(party.logo).downcase
      end

      party
    end

    parties = Party.all

    new_parties.each do |data|
      next unless data
      party = parties.find {|p| p.name.downcase == data.registered_name.downcase}

      unless party
        party = Party.new
        party.name = data.registered_name
      end

      if party.short.blank?
        party.short = data.abbreviation.blank? ? party.name.sub('The ','').sub(' of New Zealand','') : data.abbreviation
      end

      party.abbreviation = data.abbreviation unless data.abbreviation.blank?
      party.url = data.url unless data.url.blank?

      if data.logo_file
        party.logo = data.logo_file
        logo_path = "#{Rails.root}/public/images/parties/#{party.logo}"

        unless File.exists?(logo_path)
          # puts 'opening ' + data.logo
          resp = response 'www.elections.org.nz', data.logo
          if resp.code == "200"
            # puts File.dirname(logo_path)
            FileUtils.mkdir_p File.dirname(logo_path)
            File.open(logo_path, 'wb') do |f|
              f.write resp.body
            end
            # puts 'written ' + logo_path
          end
        end
      end

      # puts 'saving ' + party.name
      # puts 'short name ' + party.short
      party.save
    end; nil

  end

end

require 'morph'

class PartyProxy
  include Morph
end
