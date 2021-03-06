require_relative 'bike'
require_relative 'van'

class DockingStation

  attr_reader :bikes, :capacity

  DEFAULT_CAPACITY = 20

  def initialize(capacity = DEFAULT_CAPACITY)
    @capacity = capacity
    @bikes = []
  end

  def release_bike
    fail "There are no bikes available" if empty?
    bike = working_bikes.shift
  end

  def dock_bike(bike)
    fail "This docking station is full" if full?
    @bikes << bike
  end

  def give_broken_bikes
    broken_bikes_array = @bikes.select {|bike| bike.broken == true}
    @bikes = working_bikes
    return broken_bikes_array
  end

private

  def full?
    @bikes.count >= capacity
  end

  def empty?
    working_bikes.count == 0
  end

  def working_bikes
    @bikes.select {|bike| bike.broken == false}
  end

end
