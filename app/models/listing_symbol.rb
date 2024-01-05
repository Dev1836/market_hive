class ListingSymbol < ApplicationRecord
  belongs_to :listing_index
  enum status: { active: 0, inactive: 1, archived: 2 }
end
