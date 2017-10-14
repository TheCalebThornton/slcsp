class PlanService

  def self.determine_second_lowest_rate(plans)
    secondLowestRate = nil
    if(plans.empty?) then return secondLowestRate end
    uniquePlanRates = plans.uniq{|p| p.rate.to_f}.map(&:rate)
    if(uniquePlanRates.length > 1) then
      secondLowestRate = uniquePlanRates.sort_by!(&:to_f)[1]
    end
    secondLowestRate
  end

end
