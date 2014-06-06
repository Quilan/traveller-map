class CreateSubsectors < ActiveRecord::Migration
  def change
    create_table :subsectors do |t|
      t.string :name
      t.references :user, index: true
      t.timestamps
    end
  end
end
