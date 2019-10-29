require "csv"
require "conv"

class Mountain

  attr_accessor :name, :latitude, :longitude, :elevation

  def initialize(name, latitude, longitude, elevation)
     @name = name
     @latitude = latitude
     @longitude = longitude
     @elevation = elevation
  end

  def to_s
    "#{@name} #{@elevation}m [#{@latitude}, #{@longitude}]"
  end

  def self.import_from_file(in_file)
    ret = []
    data = CSV.parse(in_file, headers: true)
    data.each do |r|
      name = r["Peak"] + ", " + r["State"]
      lat = r["Latitude"]
      long = r["Longitude"]
      elev = Conv.feet_to_meters(r["Elevation (ft)"].to_i)
      ret << Mountain.new(name, lat, long, elev)
    end
    ret
  end

end
