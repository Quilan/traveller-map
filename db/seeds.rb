# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'csv'

# System.destroy_all
# TradeGood.destroy_all
conn = ActiveRecord::Base.connection
tables = conn.execute("show tables").map { |r| r[0] }
tables.delete "schema_migrations"
tables.each { |t| conn.execute("TRUNCATE #{t}") }

Subsector.create(name: "First Flight")
Subsector.create(name: "Too Many Feathers")

trade_codes = ["Agricultural",
"Asteroid",
"Barren",
"Desert",
"Fluid Oceans",
"Garden",
"High Population",
"High Tech",
"Ice-Capped",
"Industrial",
"Low Population",
"Low Tech",
"Non-Agricultural",
"Non-Industrial",
"Poor",
"Rich",
"Vacuum",
"Water World",
"Amber Zone",
"Red Zone"]
trade_codes.each{|t| TradeCode.create!(name: t)}

Base.create!(name: 'Navy', symbol: '★', description: "Navy Base")
Base.create!(name: 'Scout', symbol: '▲', description: "Scout Base")
Base.create!(name: 'Research', symbol: 'π', description: "Research Outpost")
Base.create!(name: 'TAS', symbol: '☼', description: "TAS Hostel")
Base.create!(name: 'Consulate', symbol: '∎', description: "Imperial Consulate")
Base.create!(name: 'Pirate', symbol: '☠', description: "WARNING: PIRATE ACTIVITY REPORTED")
Base.create!(name: 'Gas Giant', description: "Gas Giant present")

CSV.foreach("db/seeds/traveller_universe.csv", :headers => true, :header_converters => :symbol) do |system|
  system[:bases] ||= []
  system[:trade_codes] ||= []
  system[:contraband] ||= []
  system[:links] ||=[]

  # trade_codes = system[:trade_codes].split(", ").reject(&:blank?).map{|t| TradeCode.find_by_name(t)}
  if system[:travel_code]=='Amber'
    trade_codes << TradeCode.find_by_name('Amber Zone')
  elsif system[:travel_code] == 'Red'
    trade_codes << TradeCode.find_by_name('Red Zone')
  end
  bases = system[:bases].split(", ").reject(&:blank?).map{|b| Base.find_by_name(b)}
  System.create(
    :subsector => Subsector.first,
    :row => system[:row],
    :col => system[:col],
    :name => system[:name],
    :size => system[:size],
    :atmosphere => system[:atmosphere],
    :temperature => system[:temperature],
    :hydrographics => system[:hydrographics],
    :population => system[:population],
    :government => system[:government],
    :law => system[:law],
    :starport => system[:starport],
    :tech => system[:tech],
    :bases => bases,
    # :trade_codes => trade_codes,
    :contraband => system[:contraband].present? ? system[:contraband].split(", ") : [],
    :travel_code => system[:travel_code],
    :links => system[:links].present? ? system[:links].split(",").map(&:to_i) : [],
    :notes => system[:notes]
    )
end

CSV.foreach("db/seeds/traveller_universe_2.csv", :headers => true, :header_converters => :symbol) do |system|
  system[:bases] ||= []
  system[:trade_codes] ||= []
  system[:contraband] ||= []
  system[:links] ||=[]

  # trade_codes = system[:trade_codes].split(", ").reject(&:blank?).map{|t| TradeCode.find_by_name(t)}
  if system[:travel_code]=='Amber'
    trade_codes << TradeCode.find_by_name('Amber Zone')
  elsif system[:travel_code] == 'Red'
    trade_codes << TradeCode.find_by_name('Red Zone')
  end
  bases = system[:bases].split(", ").reject(&:blank?).map{|b| Base.find_by_name(b)}
  System.create(
    :subsector => Subsector.last,
    :row => system[:row],
    :col => system[:col],
    :name => system[:name],
    :size => system[:size],
    :atmosphere => system[:atmosphere],
    :temperature => system[:temperature],
    :hydrographics => system[:hydrographics],
    :population => system[:population],
    :government => system[:government],
    :law => system[:law],
    :starport => system[:starport],
    :tech => system[:tech],
    :bases => bases,
    # :trade_codes => trade_codes,
    :contraband => system[:contraband].present? ? system[:contraband].split(", ") : [],
    :travel_code => system[:travel_code],
    :links => system[:links].present? ? system[:links].split(",").map(&:to_i) : [],
    :notes => system[:notes]
    )
end

CSV.foreach('db/seeds/trade_goods.csv', :headers => true, :header_converters => :symbol) do |trade_good|
  tons = (trade_good[:tons] || "").sub(/1d6/, '').strip
  tons = 1 if tons.blank?

  available_goods = (trade_good[:available] ||"").split(', ').map{|t|
    if t == 'All'
      TradeCode.all.map{|tg| TradeCodeGood.new(trade_code_id: tg.id, kind: 'available')}
    else
      TradeCodeGood.new(trade_code_id: TradeCode.find_by_name(t).id, kind: 'available')
    end
  }.flatten

  purchase_goods = (trade_good[:purchase_dm] ||"").split(', ').map{|t|
    name, mod_for_code = t.split(/((\+|\-)\d+)/)
    name = name.strip
    mod_for_code = mod_for_code.to_i
    TradeCodeGood.new(trade_code_id: TradeCode.find_by_name(name).id, kind: 'purchase', dm: mod_for_code)
  }
  sale_goods = (trade_good[:sale_dm] ||"").split(', ').map{|t|
    name, mod_for_code = t.split(/((\+|\-)\d+)/)
    name = name.strip
    mod_for_code = mod_for_code.to_i
    TradeCodeGood.new(trade_code_id: TradeCode.find_by_name(name).id, kind: 'sale', dm: mod_for_code)
  }
  TradeGood.create(
    :name => trade_good[:type],
    :d66 => trade_good[:d66],
    :available_trade_code_goods => available_goods,
    :ton_multiplier => tons,
    :base_price => trade_good[:base_price],
    :purchase_trade_code_goods => purchase_goods,
    :sale_trade_code_goods => sale_goods,
    :examples => trade_good[:examples]
  )
end