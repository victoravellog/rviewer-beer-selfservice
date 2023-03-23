class CreateDispenserUsages < ActiveRecord::Migration[7.0]
  def change
    create_table :dispenser_usages do |t|
      t.references :dispenser, null: false, foreign_key: true
      t.datetime :open_time, default: -> { 'CURRENT_TIMESTAMP' }
      t.datetime :close_time
      t.timestamps
    end
  end
end
