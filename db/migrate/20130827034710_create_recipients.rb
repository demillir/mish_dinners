class CreateRecipients < ActiveRecord::Migration
  def change
    create_table :recipients do |t|
      t.references :unit, index: true
      t.string :phone

      t.timestamps
    end
  end
end
