class StuffUnitUuid < ActiveRecord::Migration
  def up
    Unit.where(uuid: nil).find_each do |unit|
      unit.update_attribute(:uuid, SecureRandom.uuid)
    end
  end

  def down
    # NOP
  end
end
