class CreateDivisions < ActiveRecord::Migration
  def change
    create_table :divisions do |t|
      t.string :abbr

      t.timestamps
    end
  end
end
