class SystemTradeCode < ActiveRecord::Base
  belongs_to :system
  belongs_to :trade_code
end
