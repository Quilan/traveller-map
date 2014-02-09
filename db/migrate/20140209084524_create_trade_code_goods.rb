class CreateTradeCodeGoods < ActiveRecord::Migration
  def change
    create_table :trade_code_goods, force:true do |t|
      t.references :trade_good, index: true
      t.references :trade_code, index: true
      t.integer :dm
      t.string :kind

      t.timestamps
    end
  end
end
