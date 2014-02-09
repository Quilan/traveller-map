class CreateBrokers < ActiveRecord::Migration
  def change
    create_table :brokers do |t|
      t.string :name
      t.references :system, index: true

      t.timestamps
    end
  end
end
