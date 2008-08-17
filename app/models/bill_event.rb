class BillEvent < ActiveRecord::Base

  belongs_to :bill
  belongs_to :source, :polymorphic => true

  validates_presence_of :name

  after_create :log_creation
  after_save :expire_cached_pages

  class << self

    def create_from_nzl_event nzl_event
      if nzl_event.about_type == 'Bill' && nzl_event.about_id && nzl_event.version_stage
        returning(BillEvent.new) do |e|
          e.bill_id     = nzl_event.about_id
          e.name        = nzl_event.version_stage
          e.date        = nzl_event.version_date
          e.source_type = 'NzlEvent'
          e.source_id   = nzl_event.id
        end
      else
        nil
      end
    end

    def refresh_events_from_bill bill
      create_from_bill(bill).each do |event|
        existing = find_existing event
        event.save! unless existing
      end
    end

    def find_existing event
      if event.source_id
        find_by_date_and_name_and_bill_id_and_source_type_and_source_id(event.date, event.name, event.bill_id, event.source_type, event.source_id)
      else
        find_by_date_and_name_and_bill_id(event.date, event.name, event.bill_id)
      end
    end

    def create_from_bill bill
      events = []
      debates_in_groups_by_name = bill.debates_in_groups_by_name

      bill.events_by_date.each do |date_and_stage|
        date = date_and_stage[0]
        stage = date_and_stage[1]

        debates = debates_in_groups_by_name.select {|list| list.first.normalized_name == stage}.flatten

        if debates.blank?
          # puts 'creating bill event ' + stage
          events << create_from_bill_stage(bill, stage, date)
        else
          # puts 'creating ' + debates.size.to_s + ' bill debate events for ' + stage
          debates.each do |debate|
            events << create_from_bill_debate(bill, stage, debate)
          end
        end
      end
      events
    end

    def create_from_bill_debate bill, stage, debate
      event = create_from_bill_stage bill, stage, debate.date
      event.source_type = 'Debate'
      event.source_id = debate.id
      event
    end

    def create_from_bill_stage bill, stage, date
      returning(BillEvent.new) do |e|
        e.bill_id     = bill.id
        e.name        = stage
        e.date        = date
      end
    end
  end

  def debates
    debates_in_groups_by_name, votes_by_name = bill.debates_by_name_names_votes_by_name
    debates = debates_in_groups_by_name.blank? ? nil : debates_in_groups_by_name.select {|list| list.first.normalized_name == self.name}.flatten
    debates = nil if debates.blank?
    debates
  end

  def votes
    votes_by_name = bill.votes_in_groups_by_name
    votes = votes_by_name.blank? ? nil : votes_by_name[self.name]
    votes
  end

  def has_debates?
    !debates.blank?
  end

  def has_votes?
    !votes.blank?
  end

  def is_reading_before_nov_2005?
    name && name.include?('Reading') && date < Date.new(2005,11,1)
  end

  def is_first_bill_event?
    bill.is_first_bill_event? self
  end

  def was_split_at_third_reading?
    name == 'Third Reading' && is_first_bill_event?
  end

  def set_created_and_updated_at_date_to_event_date
    if date
      event_date = (date.to_time + (60*60)).utc.beginning_of_day
      if event_date <= Time.now
        self.created_at = event_date
        self.updated_at = event_date
      else
        self.created_at = Time.now.utc unless self.created_at
        self.updated_at = Time.now.utc unless self.updated_at
      end
    end
  end

  def <=> event
    other_date = event.date
    comparison = date <=> other_date
    if comparison == 0
      other_name = event.name
      if name[/First/] && (other_name[/Second/] or other_name[/Third/])
        comparison = -1
      elsif name[/Second/] && (other_name[/Third/])
        comparison = -1
      elsif name[/Second/] && (other_name[/First/])
        comparison = +1
      elsif name[/Third/] && (other_name[/First/] or other_name[/Second/])
        comparison = +1
      else
        comparison = 0
      end
    end
    comparison
  end

  def log_creation
    puts "created: #{self.inspect}"
  end

  def expire_cached_pages
    bill.expire_cached_pages
  end
end