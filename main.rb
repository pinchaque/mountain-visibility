#!/usr/bin/env ruby

$LOAD_PATH.unshift(File.dirname(File.expand_path('.', __FILE__)))

require "pp"
require "mountain"

File.open("highpoints.csv") do |file|
  mountains = Mountain.import_from_file(file)

  mountains.each do |mtn|
    puts(mtn)
  end
end
