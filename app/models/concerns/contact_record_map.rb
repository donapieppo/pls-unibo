module ContactRecordMap
  extend ActiveSupport::Concern

  included do
    has_many :contact_records, as: :record
  end

  def contacts
    self.contact_records.map(&:contact)
  end

  def contact_ids
    self.contact_records.map(&:contact_id)
  end
end
