class Broker

  def self.broker_items_for(system)
    goods = TradeGood.available_in(system) + TradeGood.special_items(rand(6)+1)

    items = []
    goods.each do |item|
      qty = item.ton_multiplier * (rand(6)+1)
      items << {:item => item, :quantity => qty}
    end
    items
  end

  def self.print_broker_for(system)
    puts "Broker for #{system.name}"
    puts "Goods available"
    ActiveRecord::Base.silence do
      broker_items_for(system).each do |good|
        puts "Item: #{good[:item].name}"
        puts "Quantity: #{good[:quantity]} tonnes"
        puts "Purchase mod: #{good[:item].purchase_price_mod(system)}"
        puts "Sale mod: #{good[:item].sale_price_mod(system)}"
        puts "Base price: #{good[:item].base_price}"
        puts "Examples: #{good[:item].examples}"
        puts " "
      end
    end
    0
  end

end