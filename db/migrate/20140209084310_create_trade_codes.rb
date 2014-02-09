class CreateTradeCodes < ActiveRecord::Migration
  def change
    create_table :trade_codes, force: true do |t|
      t.string :name

      t.timestamps
    end
  end
end
