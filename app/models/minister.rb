# encoding: UTF-8
# == Schema Information
#
# Table name: ministers
#
#  id                 :integer          not null, primary key
#  responsible_for_id :integer          not null
#  title              :string(82)       not null
#

class Minister < ActiveRecord::Base

  belongs_to :portfolio, :foreign_key => 'responsible_for_id'

  class << self
    def from_name(name, try_again=true)
      name = name.sub('Acting', '').sub('Associate', '').downcase.squish
      minister = find(:all).select {|m| m.title.downcase == name}.first
      if minister
        minister
      elsif try_again and name.index(' of ')
        from_name name.gsub(' of ', ' for '), false
      elsif try_again and name.index(' for ')
        from_name name.gsub(' for ', ' of '), false
      else
        nil
      end
    end

    def all_minister_titles
      @all_minister_titles = all.collect(&:title).sort unless @all_minister_titles
      @all_minister_titles
    end
  end
end
