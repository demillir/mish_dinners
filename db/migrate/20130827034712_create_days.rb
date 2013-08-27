class CreateDays < ActiveRecord::Migration
  def change
    create_table :days do |t|
      t.references :unit, index: true
      t.date :date

      t.timestamps
    end
  end
end
