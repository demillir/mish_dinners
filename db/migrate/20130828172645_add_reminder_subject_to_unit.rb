class AddReminderSubjectToUnit < ActiveRecord::Migration
  def change
    add_column :units, :reminder_subject, :string
  end
end
