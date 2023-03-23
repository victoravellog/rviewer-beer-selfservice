require 'rails_helper'

RSpec.describe Dispenser, type: :model do
  let(:dispenser) { create(:dispenser) }

  describe 'validations' do
    it 'should be valid' do
      expect(dispenser).to be_valid
    end

    it 'should be invalid if flow_volume is not present' do
      dispenser.flow_volume = nil
      expect(dispenser).not_to be_valid
    end

    it 'should be invalid if flow_volume is not greater than 0' do
      dispenser.flow_volume = 0
      expect(dispenser).not_to be_valid
    end
  end

  describe 'dispenser_usages' do
    it 'should return dispenser_usages' do
      expect(dispenser.dispenser_usages).to be_empty
    end
  end
end
