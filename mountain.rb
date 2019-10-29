require "csv"
require "geo_math"

# Details for a mountain peak
class Mountain

  attr_accessor :name, :latitude, :longitude, :elevation

  def initialize(name, latitude, longitude, elevation)
     @name = name
     @latitude = latitude
     @longitude = longitude
     @elevation = elevation # in meters
  end

  def to_s
    "#{@name} (#{@elevation}m)"
  end

  # Returns how far that you can see in km from the top of the mountain
  def horizon_distance
    elev = @elevation / 1000 # convert to km
    Math.sqrt(elev**2 + (2 * GeoMath::RADIUS * elev))
  end

  # Returns distance from this mountain to another one
  def distance_to(mtn)
    GeoMath.haversine_distance(
      @latitude, @longitude, 
      mtn.latitude, mtn.longitude)
  end

  # Returns true if this mountain can see another one as determined by the
  # combined horizon distance being greater than the haversine distance.
  def can_see(mtn)
    (horizon_distance + mtn.horizon_distance) > distance_to(mtn)
  end

  # Returns array of mountains read from a file stream
  def self.import_from_file(in_file)
    ret = []
    data = CSV.parse(in_file, headers: true)
    data.each do |r|
      name = r["Peak"] + ", " + r["State"]
      lat = r["Latitude"]
      long = r["Longitude"]
      elev = GeoMath.feet_to_meters(r["Elevation (ft)"].to_i)
      ret << Mountain.new(name, lat, long, elev)
    end
    ret
  end

end
