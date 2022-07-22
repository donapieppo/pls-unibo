class Event < Activity
  has_and_belongs_to_many :contacts, through: 'activities_contacts', foreign_key: 'activity_id'
  has_and_belongs_to_many :speakers, join_table: 'activities_speakers', foreign_key: 'activity_id', class_name: 'Contact'

  has_rich_text :details

  belongs_to :edition, foreign_key: 'parent_id'
  scope :bookable, -> { where("bookable != 'no' and booking_start < NOW() and booking_end > NOW()") }

  def to_s
    self.name
  end

  def over?
    self.start_date < Date.tomorrow
  end
end
