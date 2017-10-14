require 'csv'
require_relative  'models/location'
require_relative  'models/plan'
slcsp = ARGV[0]
zips = ARGV[1] || 'zips.csv'
plans = ARGV[2] || 'plans.csv'

puts "Processing #{slcsp} ..."
#Proof of concept.. Read CSV and write it with new values
# read:
arr_of_arrs = CSV.read(slcsp)
CSV.foreach(slcsp, :col_sep => ",", :headers => true) do |row|
  location = Location.find_by_zipcode(row['zipcode'])
  #pass zipcode into method that searches Zips.csv for zip code
  #method retrieves state and rate_area
end
# manipulate:
arr_of_arrs.first << "New Row"
arr_of_arrs[1..-1].each{|row| row << 11029}

# write:
CSV.open(slcsp, 'w') do |csv|
  arr_of_arrs.each{|line| csv << line}
end


puts "... Finished Processing"
