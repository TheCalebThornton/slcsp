require 'models/location'

describe Location do
  testCsvPath = "#{File.join(File.dirname(__FILE__), '../resources/zipSmallTest.csv')}"
  describe '.find_all_by_zipcode' do
    context 'given nil zipcode' do
      it 'returns empty list' do
        locations = Location.find_all_by_zipcode(testCsvPath, nil)
        expect(locations).to eql []
      end
    end

    context 'given nil csv file path' do
      it 'returns empty list' do
        locations = Location.find_all_by_zipcode(nil, '1234')
        expect(locations).to eql []
      end
    end

    context 'given zipcode not in file' do
      it 'returns empty list' do
        locations = Location.find_all_by_zipcode(testCsvPath, '123')
        expect(locations).to eql []
      end
    end

    context 'given zipcode in file' do
      it 'returns location object' do
        locations = Location.find_all_by_zipcode(testCsvPath, '67456')
        expect(locations.length).to eql 1
        expect(locations[0].zipcode).to eql '67456'
        expect(locations[0].state).to eql 'KS'
        expect(locations[0].county_code).to eql '20113'
        expect(locations[0].name).to eql 'McPherson'
        expect(locations[0].rate_area).to eql '6'
      end
    end

    context 'given multiple zipcode entries in file' do
      it 'returns all location objects' do
        locations = Location.find_all_by_zipcode(testCsvPath, '36016')
        expect(locations.length).to eql 2
        expect(locations[0].zipcode).to eql '36016'
        expect(locations[0].state).to eql 'XL'
        expect(locations[0].county_code).to eql '11111'
        expect(locations[0].name).to eql 'NonShare'
        expect(locations[0].rate_area).to eql '10'

        expect(locations[1].zipcode).to eql '36016'
        expect(locations[1].state).to eql 'AL'
        expect(locations[1].county_code).to eql '01005'
        expect(locations[1].name).to eql 'Barbour'
        expect(locations[1].rate_area).to eql '13'
      end
    end
  end
end
