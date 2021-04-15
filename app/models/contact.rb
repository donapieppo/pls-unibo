class Contact < ApplicationRecord
  has_many :contact_records

  def records 
    self.contacts_records.map(&:record)
  end
  #has_and_belongs_to_many :activities
  #has_and_belongs_to_many :editions
  #has_and_belongs_to_many :events

  def to_s
    self.name
  end
end
