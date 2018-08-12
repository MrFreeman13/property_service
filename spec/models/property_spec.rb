require 'rails_helper'

RSpec.describe Property, type: :model do
  describe 'similar' do
    context 'select properties within 5 km radius' do
      let(:subject) { described_class.similar(52.533730, 13.426110, 'apartment', 'sell') }

      before do
        create(:property, house_number: '30A', lng: 52.533809, lat: 13.427955)
        create(:property, house_number: '21', lng: 52.533486, lat: 13.427169)
      end

      context 'models structure' do
        it 'only with necessary attributes' do
          expect(subject.first.attributes.keys).to eq(%w(id zip_code city street house_number lng lat price))
        end
      end

      context 'properties' do
        it 'returns properties in radius' do
          expect(subject.map(&:house_number)).to include(*['30A', '21'])
        end

        it 'does not return any properties outside 5 km area' do
          create(:property, house_number: '50', lng: 52.528367, lat: 13.374742)
          expect(subject.map(&:house_number)).to_not include('50')
        end

        it 'does not return properties with different offer_type' do
          create(:property, offer_type: 'rent', house_number: '10')
          expect(subject.map(&:house_number)).to_not include('10')
        end

        it 'does not return properties with different property_type' do
          create(:property, property_type: 'house', house_number: '11')
          expect(subject.map(&:house_number)).to_not include('11')
        end
      end
    end
  end
end
