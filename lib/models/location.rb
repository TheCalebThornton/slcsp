require 'csv'
class Location
  attr_accessor :zipcode, :state, :county_code, :name, :rate_area


  def initialize(zip, state, county_code, name, rate_area)
    @zipcode = zip
    @state = state
    @county_code = county_code
    @name = name
    @rate_area = rate_area
  end

  def self.find_all_by_zipcode(csvFilePath, zipcode)
    result = []
    CSV.foreach(csvFilePath, :col_sep => ",", :headers => true) do |row|
      if(row['zipcode'] == zipcode) then
        result << self.new(row['zipcode'], row['state'],row['county_code'],
                          row['name'], row['rate_area'])
      end
    end
    result
  end

  def self.determine_rate_area_by_zipcode(csvFilePath, zipcode)
    locations = self.find_all_by_zipcode(csvFilePath, zipcode)
    #if state/rate_area not the same, return nil
    nil
  end
end
