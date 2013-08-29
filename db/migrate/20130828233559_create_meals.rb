class CreateMeals < ActiveRecord::Migration
  def change
    create_table :meals do |t|
      t.string :type
      t.references :volunteer, index: true
      t.references :recipient, index: true
      t.date :date

      t.timestamps
    end

    add_index :meals, [:volunteer_id, :date]
  end
end
