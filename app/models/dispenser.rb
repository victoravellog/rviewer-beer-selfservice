class Dispenser < ApplicationRecord
  validates :flow_volume, presence: true, numericality: { greater_than: 0 }

  has_many :dispenser_usages, dependent: :destroy
end
