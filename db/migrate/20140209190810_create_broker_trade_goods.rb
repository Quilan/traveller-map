class CreateBrokerTradeGoods < ActiveRecord::Migration
  def change
    create_table :broker_trade_goods do |t|
      t.references :broker, index: true
      t.references :trade_good, index: true
      t.integer :quantity

      t.timestamps
    end
  end
end
