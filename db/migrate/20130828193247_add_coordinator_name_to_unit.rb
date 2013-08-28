class AddCoordinatorNameToUnit < ActiveRecord::Migration
  def change
    add_column :units, :coordinator_name, :string
  end
end
