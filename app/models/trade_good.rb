class TradeGood < ActiveRecord::Base

  # serialize :available
  # serialize :purchase_dm
  # serialize :sale_dm
  has_many :trade_code_goods
  has_many :available_trade_code_goods, -> {where(kind: 'available')}, class_name: "TradeCodeGood"
  has_many :available_trade_codes, through: :available_trade_code_goods, class_name: "TradeCode", source: :trade_code

  has_many :purchase_trade_code_goods, -> {where(kind: 'purchase')}, class_name: "TradeCodeGood"
  has_many :purchase_trade_codes, through: :purchase_trade_code_goods, class_name: "TradeCode", source: :trade_code

  has_many :sale_trade_code_goods, -> {where(kind: 'sale')}, class_name: "TradeCodeGood"
  has_many :sale_trade_codes, through: :sale_trade_code_goods, class_name: "TradeCode", source: :trade_code

  scope :available_in, -> (system) {
    joins(:available_trade_codes)
    .where(trade_codes: {id: system.trade_code_ids})
  }

  # def self.items_for(system)

  #   items = for_code("All")
  #   system.trade_codes.each do |code|
  #     items += for_code(code)
  #   end
  #   items.uniq
  # end

  def self.special_items(n)
    items = []
    n.times do
      res = (rand(6)+1)*10 +rand(6)+1
      items << find_by_d66(res)
    end
    items
  end


  # def self.for_code(code)
  #   where("available LIKE '%- #{code}%'")
  # end

  def purchase_price_mod(system)
    mod_for(:purchase, system) - mod_for(:sale, system)
  end

  def sale_price_mod(system)
    mod_for(:sale, system) - mod_for(:purchase, system)
  end

  def mod_for(kind, system)
    mod = 0

    send(attr).each do |code|
      name, mod_for_code = code.split(/((\+|\-)\d+)/)
      name = name.strip
      mod_for_code = mod_for_code.to_i

      if system.trade_codes.include?(name)
        mod = [mod, mod_for_code].max
      end

      if name == 'Amber Zone' && system.travel_code == 'Amber'
        mod = [mod_for_code, mod].max
      end

      if name == 'Red Zone' && system.travel_code == 'Red'
        mod = [mod_for_code, mod].max
      end

    end
  end

  def mod_for(kind, system)
    mod = 0

    send(:"#{kind}_trade_code_goods").where(trade_code_goods:
                                            {trade_code_id: system.trade_code_ids}
                                           ).each do |item|

      mod = [item.dm, mod].max
    end

    mod
  end
end
