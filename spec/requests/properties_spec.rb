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

      context 'when data does not exist for given params' do
        it 'returns empty body when property out of radius' do
          get '/properties',
              params: { lng: 52.533730, lat: 13.626110, property_type: :apartment, marketing_type: :sell }
          expect(response.body).to be_empty
          expect(response).to have_http_status(204)
        end


        it 'returns empty body when does not match property type' do
          get '/properties',
              params: { lng: 52.533730, lat: 13.426110, property_type: :single_family_house, marketing_type: :sell }
          expect(response.body).to be_empty
          expect(response).to have_http_status(204)
        end

        it 'returns empty body when does not match marketing type' do
          get '/properties',
              params: { lng: 52.533730, lat: 13.626110, property_type: :apartment, marketing_type: :rent }
          expect(response.body).to be_empty
          expect(response).to have_http_status(204)
        end
      end
    end

    context 'when params are invalid' do
      context 'when property type is invalid' do
        before do
          get '/properties',
              params: { lng: 52.533730, lat: 13.426110, property_type: :castle, marketing_type: :sell }
        end

        it 'returns status code 422' do
          expect(response).to have_http_status(422)
        end
      end

      context 'when marketing type is invalid' do
        before do
          get '/properties',
              params: { lng: 52.533730, lat: 13.426110, property_type: :apartment, marketing_type: :promo }
        end

        it 'returns status code 422' do
          expect(response).to have_http_status(422)
        end
      end

      context 'when not all required params presented' do
        before do
          get '/properties',
              params: { lng: 52.533730, lat: 13.426110, marketing_type: :sell }
        end

        it 'returns status code 422' do
          expect(response).to have_http_status(422)
        end
      end
    end
  end
end
