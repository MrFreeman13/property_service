require 'rails_helper'

RSpec.describe 'Properties API', type: :request do
  describe 'GET /properties?params' do
    before do
      create(:property, house_number: '30A', lng: 52.533809, lat: 13.427955)
      create(:property, house_number: '21', lng: 52.533486, lat: 13.427169)
    end

    context 'when params are valid' do
      context 'when data exists for given params' do
        before do
          get '/properties',
                       params: { lng: 13.426110, lat: 52.533730, property_type: :apartment, marketing_type: :sell }
        end

        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end
      end
    end
  end
end
