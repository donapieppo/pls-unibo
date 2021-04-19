class Contact < ApplicationRecord
  has_many :contact_records
  has_many :areas
  
  has_and_belongs_to_many :projects
  has_and_belongs_to_many :editions
  has_and_belongs_to_many :events

  def records 
    self.contacts_records.map(&:record)
  end

  def to_s
    self.name
  end
end
