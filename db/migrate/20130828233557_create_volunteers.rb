class CreateVolunteers < ActiveRecord::Migration
  def change
    create_table :volunteers do |t|
      t.references :unit, index: true
      t.string :name
      t.string :phone
      t.string :email

      t.timestamps
    end

    add_index :volunteers, [:unit_id, :name ]
    add_index :volunteers, [:unit_id, :phone]
    add_index :volunteers, [:unit_id, :email]
  end
end
