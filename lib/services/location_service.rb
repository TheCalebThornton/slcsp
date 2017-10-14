class LocationService

  def self.determine_rate_area_for_locations(locations)
    state_rate_area = {'state'=> nil, 'rate_area' => nil}
    uniqeLocations = locations.uniq {|l| [l.state, l.rate_area]}
    if(uniqeLocations.length == 1) then
      state_rate_area['state'] = uniqeLocations[0].state
      state_rate_area['rate_area'] = uniqeLocations[0].rate_area
    end
    state_rate_area
  end

end
