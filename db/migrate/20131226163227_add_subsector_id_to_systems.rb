class AddSubsectorIdToSystems < ActiveRecord::Migration
  def change
    add_column :systems, :subsector_id, :integer
  end
end
