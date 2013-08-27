class AddUuidToUnit < ActiveRecord::Migration
  def change
    add_column :units, :uuid, :string
  end
end
