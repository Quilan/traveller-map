class CreateSystems < ActiveRecord::Migration
  def change
    create_table :systems do |t|
      t.string :name
      t.integer :col
      t.integer :row
      t.integer :size
      t.integer :atmosphere
      t.string :temperature
      t.integer :hydrographics
      t.integer :population
      t.integer :government
      t.integer :law
      t.string :starport
      t.integer :tech
      t.string :links
      t.string :bases
      t.string :trade_codes
      t.string :travel_code
      t.string :contraband
      t.string :notes
      t.timestamps
    end
  end
end
