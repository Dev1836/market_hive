class ListingIndex < ApplicationRecord
  enum status: { active: 0, inactive: 1, archived: 2 }
  has_many :listing_symbols, dependent: :destroy
end
