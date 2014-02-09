class CreateBaseSystems < ActiveRecord::Migration
  def change
    create_table :base_systems, force: true do |t|
      t.references :system, index: true
      t.references :base, index: true

      t.timestamps
    end
  end
end
