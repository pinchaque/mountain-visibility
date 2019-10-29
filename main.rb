#!/usr/bin/env ruby

$LOAD_PATH.unshift(File.dirname(File.expand_path('.', __FILE__)))

require "mountain"

File.open("highpoints.csv") do |file|
  mountains = Mountain.import_from_file(file)

  # Pairwise comparison between all mountains
  for i in 0...mountains.length
    mtn_i = mountains[i]
    for j in i+1...mountains.length
      mtn_j = mountains[j]

      next unless mtn_i.can_see(mtn_j)
      dist = mtn_i.distance_to(mtn_j)

      puts("'#{mtn_i}' and '#{mtn_j}' Distance:#{dist}km < Visibility:" +
        "#{mtn_i.horizon_distance + mtn_j.horizon_distance}km")
    end
  end
end
