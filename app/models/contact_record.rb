class ContactRecord < ApplicationRecord
  belongs_to :contact
  belongs_to :record, polymorphic: true
end
