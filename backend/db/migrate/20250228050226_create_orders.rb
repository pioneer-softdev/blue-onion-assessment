class CreateOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :orders do |t|
      t.date :ordered_at
      t.string :item_type
      t.decimal :price_per_item
      t.integer :quantity
      t.decimal :shipping_cost
      t.decimal :tax_rate
      t.decimal :total_amount

      t.timestamps
    end
  end
end
