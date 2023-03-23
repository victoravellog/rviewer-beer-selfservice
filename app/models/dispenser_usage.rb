class DispenserUsage < ApplicationRecord
  belongs_to :dispenser

  validates :open_time, with: :check_dispenser_not_closed, on: :create
  validates :close_time, with: :check_dispenser_opened, on: :update

  def check_dispenser_not_closed
    return if dispenser.dispenser_usages.where(close_time: nil).empty?

    errors.add(:dispenser, 'is already opened')
  end

  def check_dispenser_opened
    return unless dispenser.dispenser_usages.where(close_time: nil).empty?

    errors.add(:dispenser, 'is already closed')
  end

  def spending
    fixed_close_time = close_time
    fixed_close_time = Time.now unless close_time
    ((fixed_close_time - open_time) * dispenser.flow_volume).round(4)
  end
end
