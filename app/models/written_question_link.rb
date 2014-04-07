# encoding: UTF-8
# == Schema Information
#
# Table name: written_question_links
#
#  id        :integer          not null, primary key
#  from_id   :integer
#  to_id     :integer
#  link_type :string(255)
#

class WrittenQuestionLink < ActiveRecord::Base
end
