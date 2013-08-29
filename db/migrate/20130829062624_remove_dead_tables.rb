class RemoveDeadTables < ActiveRecord::Migration
  def up
    drop_table :appointments
    drop_table :days
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
