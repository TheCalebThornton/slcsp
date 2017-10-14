require 'models/plan'

describe Plan do
  describe '.find_all_by_state_and_rate_area_and_metal_level' do
    testCsvPath = "#{File.join(File.dirname(__FILE__), '../resources/plansSmallTest.csv')}"
    context 'given nil state' do
      it 'returns empty list' do
        plans = Plan.find_all_by_state_and_rate_area_and_metal_level(testCsvPath, nil, '12', 'gold')
        expect(plans).to eql []
      end
    end

    context 'given nil rate' do
      it 'returns empty list' do
        plans = Plan.find_all_by_state_and_rate_area_and_metal_level(testCsvPath, 'OH', nil, 'silver')
        expect(plans).to eql []
      end
    end

    context 'given nil metal_level' do
      it 'returns empty list' do
        plans = Plan.find_all_by_state_and_rate_area_and_metal_level(testCsvPath, 'OH', '12', nil)
        expect(plans).to eql []
      end
    end

    context 'given nil csv file path' do
      it 'returns empty list' do
        plans = Plan.find_all_by_state_and_rate_area_and_metal_level(nil, 'OH', '12', 'bronze')
        expect(plans).to eql []
      end
    end

    context 'given state/rate_area/metal_level combo not in file' do
      it 'returns empty list' do
        plans = Plan.find_all_by_state_and_rate_area_and_metal_level(testCsvPath, 'OH', 43, 'ilver')
        expect(plans).to eql []
      end
    end

    context 'given state/rate_area/metal_level combo in file' do
      it 'returns location object' do
        plans = Plan.find_all_by_state_and_rate_area_and_metal_level(testCsvPath, 'FL', '60', 'Silver')
        expect(plans[0].plan_id).to eql '26325VH2723968'
        expect(plans[0].state).to eql 'FL'
        expect(plans[0].metal_level).to eql 'Silver'
        expect(plans[0].rate).to eql '421.43'
        expect(plans[0].rate_area).to eql '60'
      end
    end

    context 'given multiple state/rate_area/metal_level combo entries in file' do
      it 'returns first location object' do
        plans = Plan.find_all_by_state_and_rate_area_and_metal_level(testCsvPath, 'IL', '5', 'Gold')
        expect(plans[0].plan_id).to eql '09846WB8636631'
        expect(plans[0].state).to eql 'IL'
        expect(plans[0].metal_level).to eql 'Gold'
        expect(plans[0].rate).to eql '361.69'
        expect(plans[0].rate_area).to eql '5'

        expect(plans[1].plan_id).to eql '09846WB8636632'
        expect(plans[1].state).to eql 'IL'
        expect(plans[1].metal_level).to eql 'Gold'
        expect(plans[1].rate).to eql '345'
        expect(plans[1].rate_area).to eql '5'

        expect(plans[2].plan_id).to eql '09846WB8636633'
        expect(plans[2].state).to eql 'IL'
        expect(plans[2].metal_level).to eql 'Gold'
        expect(plans[2].rate).to eql '71.8'
        expect(plans[2].rate_area).to eql '5'
      end
    end

  end
end
