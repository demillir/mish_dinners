class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units do |t|
      t.references :division, index: true
      t.string :abbr
      t.string :coordinator_email
      t.string :meal_time
      t.text :volunteer_pitch

      t.timestamps
    end
  end
end
