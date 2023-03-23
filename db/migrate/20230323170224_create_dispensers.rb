class CreateDispensers < ActiveRecord::Migration[7.0]
  def change
    create_table :dispensers do |t|
      t.decimal :flow_volume, precision: 4, scale: 4
      t.timestamps
    end
  end
end
