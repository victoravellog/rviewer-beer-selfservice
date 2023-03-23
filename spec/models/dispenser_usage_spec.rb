require 'rails_helper'

RSpec.describe DispenserUsage, type: :model do
  let(:dispenser) { create(:dispenser) }
  let(:dispenser_usage) { create(:dispenser_usage, dispenser:, close_time: nil) }

  describe 'validations' do
    it 'should be valid' do
      expect(dispenser_usage).to be_valid
    end

    it 'should be invalid if dispenser is already opened' do
      dispenser.dispenser_usages.create!(open_time: Time.now)
      expect { dispenser.dispenser_usages.create!(open_time: Time.now) }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'should be invalid if dispenser is already closed' do
      dispenser_usage.update!(close_time: Time.now)
      expect { dispenser_usage.update!(close_time: Time.now) }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  describe 'spending' do
    it 'should return spending' do
      expect(dispenser_usage.spending).not_to eq(0.0)
    end
  end
end
