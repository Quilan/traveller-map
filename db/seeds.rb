# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'csv'

CSV.foreach("db/seeds/traveller_universe.csv", :headers => true, :header_converters => :symbol) do |system|
  system[:bases] ||= []
  system[:trade_codes] ||= []
  system[:contraband] ||= []
  system[:links] ||=[]


  System.create(
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
    :bases => system[:bases].present? ? system[:bases].split(", ") : [],
    :trade_codes => system[:trade_codes].present? ? system[:trade_codes].split(", ") : [],
    :contraband => system[:contraband].present? ? system[:contraband].split(", ") : [],
    :travel_code => system[:travel_code],
    :links => system[:links].present? ? system[:links].split(",").map(&:to_i) : [],
    :notes => system[:notes]
    )
end