# Helper functions for geographic math
class GeoMath

  RADIUS = 6378.8

  # Converts feet to meters
  def self.feet_to_meters(ft)
    ft * 0.3048
  end

  # Converts degrees to radians
  def self.deg_to_rad(deg)
    deg.to_f * Math::PI / 180.0
  end

  # Returns distance between two points on earth in km using haversine formula
  def self.haversine_distance(lat1, long1, lat2, long2)
    lat1_rad, long1_rad, lat2_rad, long2_rad = 
      [lat1, long1, lat2, long2].map { |d| self.deg_to_rad(d) }

    diff_long = long2_rad - long1_rad
    diff_lat = lat2_rad - lat1_rad

    a = Math.sin(diff_lat/2)**2 + 
      Math.cos(lat1_rad) * Math.cos(lat2_rad) * Math.sin(diff_long/2)**2
    RADIUS * 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a))
  end

end
