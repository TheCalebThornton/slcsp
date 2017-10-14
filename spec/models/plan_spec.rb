require 'models/plan'

describe Plan do
  describe '.find_by_state_and_rate_area' do
    testCsvPath = "#{File.join(File.dirname(__FILE__), '../resources/plansSmallTest.csv')}"
    context 'given nil state' do
      it 'returns nil' do
        plan = Plan.find_by_state_and_rate_area(testCsvPath, nil, '12')
        expect(plan).to eql nil
      end
    end

    context 'given nil rate' do
      it 'returns nil' do
        plan = Plan.find_by_state_and_rate_area(testCsvPath, 'OH', nil)
        expect(plan).to eql nil
      end
    end

    context 'given state/rate_area combo not in file' do
      it 'returns nil' do
        plan = Plan.find_by_state_and_rate_area(testCsvPath, 'OH', '12')
        expect(plan).to eql nil
      end
    end

    context 'given state/rate_area combo in file' do
      it 'returns location object' do
        plan = Plan.find_by_state_and_rate_area(testCsvPath, 'GA', 7)
        expect(plan.zipcode).to eql '36016'
        expect(plan.state).to eql 'AL'
        expect(plan.county_code).to eql '01005'
        expect(plan.name).to eql 'Barbour'
        expect(plan.rate_area).to eql '13'
      end
    end

    context 'given multiple zipcode entries in file' do
      it 'returns first location object' do
        location = Plan.find_by_zipcode(testCsvPath, '36749')
        expect(location.zipcode).to eql '36749'
        expect(location.state).to eql 'AL'
        expect(location.county_code).to eql '01001'
        expect(location.name).to eql 'Autauga'
        expect(location.rate_area).to eql '11'
      end
    end

  end
end
