class CreateSystemTradeCodes < ActiveRecord::Migration
  def change
    create_table :system_trade_codes, force: true do |t|
      t.references :system, index: true
      t.references :trade_code, index: true

      t.timestamps
    end
  end
end
