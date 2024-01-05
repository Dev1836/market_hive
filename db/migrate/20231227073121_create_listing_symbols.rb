class CreateListingSymbols < ActiveRecord::Migration[7.1]
  def change
    create_table :listing_symbols do |t|
      t.string :name
      t.integer :status
      t.references :listing_index, null: false, foreign_key: true

      t.timestamps
    end
  end
end
