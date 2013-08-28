class AddPerformanceIndexes < ActiveRecord::Migration
  def change
    add_index :divisions,    :abbr
    add_index :units,        :abbr
    add_index :appointments, :name
    add_index :appointments, :phone
    add_index :appointments, :email
  end
end
