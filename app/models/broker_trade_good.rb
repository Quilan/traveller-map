class BrokerTradeGood < ActiveRecord::Base
  belongs_to :broker
  belongs_to :trade_good
end
