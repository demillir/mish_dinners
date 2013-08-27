class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.references :day, index: true
      t.references :recipient, index: true
      t.string :name
      t.string :phone
      t.string :email
      t.string :css_class

      t.timestamps
    end
  end
end
