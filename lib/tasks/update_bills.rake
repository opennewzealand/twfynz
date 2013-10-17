require File.dirname(__FILE__) + '/../bill_proxy.rb'

require 'hpricot'

namespace :kiwimp do

  desc 'update bill events'
  task :update_bill_events => :environment do
    Bill.find_each do |bill|
      BillEvent.refresh_events_from_bill(bill)
    end
  end

  desc 'downloads new bills'
  task :get_new_bills => :environment do
    update_bills false
    # bills = Bill.find_all.sort { |a,b| a.id <=> b.id }
  end

  desc 'updates existing bills'
  task :update_bills => :environment do
    update_bills
    bills = Bill.find(:all).sort { |a,b| a.id <=> b.id }

    File::open(File.dirname(__FILE__) + '/../../db/current_bills.yml', 'w') do |file|
      file.write(bills.to_yaml)
    end
  end

  def update_the_bill bill, updated_bill
    if bill.parliament_url != updated_bill.parliament_url
      updated_bill.populate_parliament_id
      updated_bill.save
    end
    puts '  update bill ' + bill.bill_name
    bill.update_attributes! updated_bill.attributes
    bill.reload
    BillEvent.refresh_events_from_bill(bill)
  end

  def has_changed? bill, updated_bill
    bill_attributes = bill.attributes
    changed = false
    updated_bill.attributes.each_pair do |attribute, value|
      if bill_attributes[attribute].to_s != value.to_s
        puts '  CHANGED ' + attribute.to_s + ' old: ' + bill_attributes[attribute].to_s + ', new: ' + value.to_s
        changed = true
        break
      end
    end
    changed
  end

  def try_bill_update url, bill, updated_bill=nil
    if !bill.current? && !bill.missing_events?
      puts '  ignoring: as have bill that is not current'
    else
      updated_bill = BillProxy.new(url).create_bill unless updated_bill
      updated_bill.id = bill.id
      updated_bill.url = bill.url unless bill.url.blank?
      updated_bill.parliament_id = bill.parliament_id unless bill.parliament_id.blank?

      if has_changed?(bill, updated_bill) || bill.missing_events?
        puts '  bill missing events' if bill.missing_events?
        update_the_bill bill, updated_bill
      else
        puts '  not changed'
      end
    end
  end

  def save_new_bill url, name, update_existing
    bill_details = BillProxy.new(url)
    bill = bill_details.create_bill
    old_bills = []

    if (bill.formerly_part_of_id)
      matching_field = 'formerly_part_of_id'
      old_bills = Bill.find_all_by_bill_name_and_formerly_part_of_id_and_royal_assent(name, bill.formerly_part_of_id, bill.royal_assent)
    end

    if (old_bills.size == 0 and bill.introduction)
      matching_field = 'introduction'
      old_bills = Bill.find_all_by_bill_name_and_introduction(name, bill.introduction)

      if (old_bills.size == 0 and !bill.former_name.blank?)
        old_bills = Bill.find_all_by_bill_name_and_introduction(bill.former_name, bill.introduction)
      end

      if old_bills.size == 1 && old_bills.first.formerly_part_of_id != bill.formerly_part_of_id
        old_bills = [] # not a match after all
      end
    end

    if old_bills.size == 1
      if update_existing
        puts "trying to update #{old_bills.size} bill with the same name and #{matching_field}: " + old_bills.first.inspect
        try_bill_update url, old_bills.first, bill
      else
        puts "not saving, as found #{old_bills.size} bill with the same name and #{matching_field}"
      end
    elsif old_bills.size > 0
      raise "confused #{old_bills.size} bills with the same name and introduction: " + old_bills.inspect

    elsif old_bills.size == 0
      puts 'trying to save'
      bill.populate_parliament_id

      if Bill.find_all_by_url(bill.url).size > 0
        if bill.earliest_date
          bill.url = bill.url+'_'+bill.earliest_date.to_s[0..3]
          puts "new bill " + bill.url + "\n        " + bill.bill_no.to_s + " | " + bill.bill_name
          bill.save!
        else
          puts '  ignoring: as no earliest date to make unique url : ' + bill.parliament_url
        end
      else
        puts 'new bill ' + bill.bill_name
        bill.save!
      end
    end
  end

  def update_bill update_existing, url, name, bill_no
    bill_no = nil if bill_no.blank?
    parliament_id = Bill.parliament_id(url)

    bill = Bill.find_by_parliament_id(parliament_id)
    bill = Bill.find_by_parliament_url(url) unless bill

    if bill
      try_bill_update url, bill if update_existing
    elsif bill_no
      bills = Bill.find_all_by_bill_name_and_bill_no(name, bill_no)
      puts "  (found #{bills.size} existing bill#{bills.size == 1 ? 's' : ''})"
      if bills.size > 1
        puts "  ignoring: as have #{bills.size} bills with this name and bill_no, urls are: " + bills.collect(&:parliament_url).join(', ')
      elsif bills.size == 1
        try_bill_update url, bills.first if update_existing
      else
        save_new_bill url, name, update_existing
      end
    else
      save_new_bill url, name, update_existing
    end
  end

  def update_bills update_existing=true
    try_count = 0
    bills = []
    while bills.empty? and try_count < 3
      try_count += 1
      begin
        bills = get_bill_list
      rescue Exception => e
        puts 'problem ... trying again'
      end
    end
    bills.sort!{|a,b| Date.parse(a[:last_activity]) - Date.parse(b[:last_activity])}
    bills.each_with_index do |bill, i|
      update_bill(update_existing, bill[:url], bill[:name], bill[:ref])
    end
  end

  def get_bill_list
    bill_list_url = 'http://www.parliament.nz/en-nz/PB/Legislation/Bills/?Criteria.ViewAll=1'
    p "downloading list of bills: #{bill_list_url}"
    bills = []

    doc = Hpricot open(bill_list_url)

    (doc/'table.listing tbody tr').each do |b|
      bill = {}
      bill[:name] = b.at('h4 a').inner_text
      bill[:url] = "http://www.parliament.nz/" + b.at('h4 a')[:href]
      bill[:last_activity] = b.at('td:nth(1)').inner_text.to_s.squish
      bill[:ref] = b.at('td:nth(2)').inner_text.to_s.squish
      bills << bill
    end

    bills
  end

end
