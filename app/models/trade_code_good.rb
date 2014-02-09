class TradeCodeGood < ActiveRecord::Base
  belongs_to :trade_good
  belongs_to :trade_code
end
