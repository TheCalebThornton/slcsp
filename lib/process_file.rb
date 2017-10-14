require 'csv'
require_relative  'models/location'
require_relative  'models/plan'
require_relative  'services/location_service'
require_relative  'services/plan_service'

class SlcspProcessor
  def self.findRateForZipCode(zip_csv, plans_csv, zipcode)
    rate_for_zip = nil
    locations = Location.find_all_by_zipcode(zip_csv, zipcode)
    rate_area_map = LocationService.determine_rate_area_for_locations(locations)
    plans = Plan.find_all_by_state_and_rate_area_and_metal_level(plans_csv, rate_area_map['state'], rate_area_map['rate_area'], 'Silver')
    rate_for_zip = PlanService.determine_second_lowest_rate(plans)
    rate_for_zip
  end
end



slcsp = ARGV[0]
zips = ARGV[1] || 'zips.csv'
plans = ARGV[2] || 'plans.csv'

puts "Processing #{slcsp} ..."
slcsp_contents = [['zipcode','rate']]
CSV.foreach(slcsp, :col_sep => ",", :headers => true) do |row|
  rate = SlcspProcessor.findRateForZipCode(zips, plans, row['zipcode'])
  slcsp_contents << [row['zipcode'], rate]
end
CSV.open(slcsp, 'w') do |csv|
  slcsp_contents.each{|line| csv << line}
end
puts "... Finished Processing"
