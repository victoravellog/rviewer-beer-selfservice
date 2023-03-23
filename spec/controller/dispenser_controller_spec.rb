require 'rails_helper'

RSpec.describe DispenserController, type: :controller do
  let(:dispenser) { create(:dispenser) }

  describe 'POST #create' do
    it 'should create new dispenser' do
      aggregate_failures do
        expect { post :create, params: { dispenser: attributes_for(:dispenser), format: :json } }.to change(Dispenser, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end

    it 'should not create new dispenser if flow_volume is not present' do
      aggregate_failures do
        expect { post :create, params: { dispenser: attributes_for(:dispenser, flow_volume: nil), format: :json } }.not_to change(Dispenser, :count)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT #open' do
    it 'should open dispenser' do
      put :open, params: { id: dispenser.id }, format: :json

      aggregate_failures do
        expect(dispenser.dispenser_usages.last.close_time).to be_nil
        expect(response).to have_http_status(:ok)
      end
    end

    it 'should not open dispenser if it is already opened' do
      dispenser.dispenser_usages.create!(open_time: Time.now)
      put :open, params: { id: dispenser.id }, format: :json

      aggregate_failures do
        expect(JSON.parse(response.body)['error']).to eq('Validation failed: Dispenser is already opened')
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    it 'should not open dispenser if it not exists' do
      put :open, params: { id: 0 }, format: :json

      aggregate_failures do
        expect(JSON.parse(response.body)['error']).to eq('Couldn\'t find Dispenser with \'id\'=0')
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'PUT #close' do
    it 'should close dispenser' do
      dispenser.dispenser_usages.create!(open_time: Time.now)
      put :close, params: { id: dispenser.id }, format: :json

      aggregate_failures do
        expect(dispenser.dispenser_usages.last.close_time).not_to be_nil
        expect(response).to have_http_status(:ok)
      end
    end

    it 'should not close dispenser if it is already closed or is not opened' do
      dispenser.dispenser_usages.create!(open_time: Time.now, close_time: Time.now + 1.minute)
      put :close, params: { id: dispenser.id }, format: :json

      aggregate_failures do
        expect(JSON.parse(response.body)['error']).to eq('Validation failed: Dispenser is already closed')
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    it 'should not close dispenser if it is not opened' do
      put :close, params: { id: dispenser.id }, format: :json

      aggregate_failures do
        expect(JSON.parse(response.body)['error']).to eq('Dispenser is not open')
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'GET #spending' do
    it 'should return spending' do
      dispenser.dispenser_usages.create!(open_time: Time.now, close_time: Time.now + 1.minute)
      get :spending, params: { id: dispenser.id }, format: :json

      aggregate_failures do
        expect(response.body['amount']).not_to eq('0.0')
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
