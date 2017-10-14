require 'services/location_service'
require 'models/location'

describe LocationService do
  describe '.determine_rate_area_for_locations' do
    context 'given empty list' do
      it 'returns nil state and rate_area' do
        rate_area = LocationService.determine_rate_area_for_locations([])
        expect(rate_area['state']).to eql nil
        expect(rate_area['rate_area']).to eql nil
      end
    end

    context 'given list with one location' do
      it 'returns state and rate_area' do
        locations = [Location.new('12345', 'ZZ', '12022', 'cnty1', '131')]
        rate_area = LocationService.determine_rate_area_for_locations(locations)
        expect(rate_area['state']).to eql 'ZZ'
        expect(rate_area['rate_area']).to eql '131'
      end
    end

    context 'given a list of multiple locations' do
      it 'returns state and rate_area' do
        locations = [Location.new('12345', 'OH', '12022', 'cnty1', '11'),
                    Location.new('12345', 'OH', '11111', 'cnty121', '11'),
                    Location.new('12345', 'OH', '34343', 'cnty', '11')]

        rate_area = LocationService.determine_rate_area_for_locations(locations)
        expect(rate_area['state']).to eql 'OH'
        expect(rate_area['rate_area']).to eql '11'
      end
    end

    context 'given a list of multiple locations that dont share rate_area' do
      it 'returns nil state and rate_area' do
        locations = [Location.new('12345', 'OH', '12022', 'cnty1', '11'),
                    Location.new('12345', 'OH', '12022', 'cnty1', '12'),
                    Location.new('12345', 'OH', '12022', 'cnty1', '11')]

        rate_area = LocationService.determine_rate_area_for_locations(locations)
        expect(rate_area['state']).to eql nil
        expect(rate_area['rate_area']).to eql nil
      end
    end

    context 'given a list of multiple locations that dont share state' do
      it 'returns nil state and rate_area' do
        locations = [Location.new('12345', 'OH', '12022', 'cnty1', '11'),
                    Location.new('12345', 'AB', '12022', 'cnty1', '11'),
                    Location.new('12345', 'OH', '12022', 'cnty1', '11')]

        rate_area = LocationService.determine_rate_area_for_locations(locations)
        expect(rate_area['state']).to eql nil
        expect(rate_area['rate_area']).to eql nil
      end
    end
  end
end
