require 'services/plan_service'
require 'models/plan'

describe PlanService do
  describe '.determine_second_lowest_rate' do
    context 'given empty list' do
      it 'returns nil' do
        secondLowestRate = PlanService.determine_second_lowest_rate([])
        expect(secondLowestRate).to eql nil
      end
    end

    context 'given list with one plan' do
      it 'returns nil' do
        plans = [Plan.new('12345', 'OH', 'Plat', '34', '11')]
        secondLowestRate = PlanService.determine_second_lowest_rate(plans)
        expect(secondLowestRate).to eql nil
      end
    end

    context 'given list with multiple plans' do
      it 'returns second lowest rate' do
        plans = [Plan.new('12345', 'OH', 'Plat', '32', '11'),
                Plan.new('12345', 'OH', 'Plat', '33', '11'),
                Plan.new('12345', 'OH', 'Plat', '34', '11')]
        secondLowestRate = PlanService.determine_second_lowest_rate(plans)
        expect(secondLowestRate).to eql '33'
      end
    end

    context 'given list with multiple plans sharing rates' do
      it 'returns second lowest unique rate' do
        plansMultipleLowest = [Plan.new('12345', 'OH', 'Gold', '1.0', '11'),
                                Plan.new('1', 'ZZ', 'Silver', '1', '34'),
                                Plan.new('3221', 'AS', 'Green', '1.1', '12'),
                                Plan.new('23qw', 'QW', 'Gold', '3', '44'),
                                Plan.new('as123', 'OH', 'Plat', '4', '55'),
                                Plan.new('43ee', 'ER', 'Gold', '5', '1')]
        secondLowestRate = PlanService.determine_second_lowest_rate(plansMultipleLowest)
        expect(secondLowestRate).to eql '1.1'
      end

      it 'returns second lowest unique rate' do
        plansMultipleSecondlowest = [Plan.new('12345', 'OH', 'Gold', '10', '11'),
                                Plan.new('1', 'ZZ', 'Silver', '13', '34'),
                                Plan.new('3221', 'AS', 'Green', '2', '12'),
                                Plan.new('23qw', 'QW', 'Gold', '2.1', '44'),
                                Plan.new('as123', 'OH', 'Plat', '2', '55'),
                                Plan.new('43ee', 'ER', 'Gold', '1', '1')]
        secondLowestRate = PlanService.determine_second_lowest_rate(plansMultipleSecondlowest)
        expect(secondLowestRate).to eql '2'
      end

      it 'returns second lowest unique rate' do
        plansMultipleHighRates = [Plan.new('12345', 'OH', 'Gold', '1', '11'),
                                Plan.new('1', 'ZZ', 'Silver', '1.34', '34'),
                                Plan.new('3221', 'AS', 'Green', '2.1', '12'),
                                Plan.new('23qw', 'QW', 'Gold', '2.1', '44'),
                                Plan.new('as123', 'OH', 'Plat', '3', '55'),
                                Plan.new('43ee', 'ER', 'Gold', '5', '1')]
        secondLowestRate = PlanService.determine_second_lowest_rate(plansMultipleHighRates)
        expect(secondLowestRate).to eql '1.34'
      end
    end
  end
end
