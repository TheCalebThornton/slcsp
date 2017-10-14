class Plan
  attr_accessor :plan_id :state :metal_level :rate :rate_area


  def initialize(state, county_code, name, rate_area)
    @state = state
    @county_code = county_code
    @name = name
    @rate_area = rate_area
  end

  def self.find_by_(file_path)
    #TODO search Zips.csv for state and rate_area values
    #if multiple records for one zip code, return nil
    self.new('SL', 'CNTY', 'NAME', '123')
  end
end
