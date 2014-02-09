class TradeGood < ActiveRecord::Base

  serialize :available
  serialize :purchase_dm
  serialize :sale_dm

  def self.items_for(system)
    items = for_code("All")
    system.trade_codes.each do |code|
      items += for_code(code)
    end
    items.uniq
  end

  def self.special_items(n)
    items = []
    n.times do
      res = (rand(6)+1)*10 +rand(6)+1
      items << find_by_d66(res)
    end
    items
  end


  def self.for_code(code)
    where("available LIKE '%- #{code}%'")
  end

  def purchase_price_mod(system)
    mod_for(:purchase_dm, system) - mod_for(:sale_dm, system)
  end

  def sale_price_mod(system)
    mod_for(:sale_dm, system) - mod_for(:purchase_dm, system)
  end

  def mod_for(attr, system)
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

    mod
  end
end
