class Snippet < ApplicationRecord
  belongs_to :edition, foreign_key: :activity_id
  has_rich_text :description
end
