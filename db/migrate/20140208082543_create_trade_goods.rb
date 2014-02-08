class CreateTradeGoods < ActiveRecord::Migration
  def change
    create_table :trade_goods do |t|
      t.string :name
      t.text :available
      t.integer :d66
      t.integer :ton_multiplier
      t.integer :base_price
      t.text :purchase_dm
      t.text :sale_dm
      t.text :examples

      t.timestamps
    end
  end
end
