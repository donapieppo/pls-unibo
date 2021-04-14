module ContactRecordMap
  extend ActiveSupport::Concern

  included do
    has_many :contact_records, as: :record
  end

  def contacts
    contact_records.map(&:contact)
  end
end
