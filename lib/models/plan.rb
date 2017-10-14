require 'csv'
class Plan
  attr_accessor :plan_id, :state, :metal_level, :rate, :rate_area

  def initialize(plan_id, state, metal_level, rate, rate_area)
    @plan_id = plan_id
    @state = state
    @metal_level = metal_level
    @rate = rate
    @rate_area = rate_area
  end

  def self.find_all_by_state_and_rate_area_and_metal_level(csvFilePath, state, rate_area, metal_level)
    plans = []
    if(csvFilePath == nil or state == nil or rate_area == nil or metal_level == nil) then
      return plans
    end
    CSV.foreach(csvFilePath, :col_sep => ",", :headers => true) do |row|
      if(row['state'] == state and row['rate_area'] == rate_area and row['metal_level'] == metal_level) then
        plans << self.new(row['plan_id'], row['state'], row['metal_level'],
                          row['rate'], row['rate_area'])
      end
    end
    plans
  end
end
