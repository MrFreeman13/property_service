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
                       params: { lng: 52.533730, lat: 13.426110, property_type: :apartment, marketing_type: :sell }
        end

        it 'return properties in 5km radius' do
          expect(json).not_to be_empty
          expect(json).to eq(
                            [
                               {
                                 'house_number' => '30A',
                                 'street' => 'Marienburger Straße',
                                 'city' => 'Berlin',
                                 'zip_code' => '10405',
                                 'state' => 'Berlin',
                                 'lat' => '13.427955',
                                 'lng' => '52.533809',
                                 'price' => '350000.00'

                               },
                               {
                                 'house_number' => '21',
                                 'street' => 'Marienburger Straße',
                                 'city' => 'Berlin',
                                 'zip_code' => '10405',
                                 'state' => 'Berlin',
                                 'lat' => '13.427169',
                                 'lng' => '52.533486',
                                 'price' => '350000.00'
                               }
                            ]
                          )
        end

        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end
      end
    end
  end
end