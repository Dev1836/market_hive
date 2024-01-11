class CreateStocks < ActiveRecord::Migration[7.1]
  def change
    create_table :stocks do |t|
      t.string :symbol
      t.string :index_name
      t.integer :prev_price
      t.integer :high_price
      t.integer :low_price
      t.integer :open_price
      t.integer :per_change
      t.integer :last_price
      t.bigint :total_traded_volume
      t.bigint :total_traded_value
    end
  end
end
