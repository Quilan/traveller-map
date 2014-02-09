class TradeCode < ActiveRecord::Base

  has_many :available_trade_code_goods, -> {where(kind: 'available')}, class_name: "TradeCodeGood"
  has_many :available_trade_goods, through: :available_trade_code_goods, class_name: "TradeGood", source: :trade_good

  has_many :purchase_trade_code_goods, -> {where(kind: 'purchase')}, class_name: "TradeCodeGood"
  has_many :purchase_trade_goods, through: :available_trade_code_goods, class_name: "TradeGood", source: :trade_good

  has_many :sale_trade_code_goods, -> {where(kind: 'sale')}, class_name: "TradeCodeGood"
  has_many :sale_trade_goods, through: :available_trade_code_goods, class_name: "TradeGood", source: :trade_good
end
