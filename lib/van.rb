require_relative 'docking_station'

class Van

attr_reader :broken_bikes

 def initialize
   @broken_bikes = []
 end

 def collect_broken(station)
   @broken_bikes = station.give_broken_bikes
 end

end
