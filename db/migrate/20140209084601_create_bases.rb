class CreateBases < ActiveRecord::Migration
  def change
    create_table :bases, force: true do |t|
      t.string :name
      t.string :symbol
      t.string :description
      t.timestamps
    end
  end
end
