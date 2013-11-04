class AddNameAndInitialsToRecipients < ActiveRecord::Migration
  def change
    add_column :recipients, :name, :string
    add_column :recipients, :initials, :string
  end
end
