require 'docking_station.rb'

describe DockingStation do

  it {is_expected.to respond_to :release_bike}

  describe '#release_bike' do

    it 'gets a bike from docked bikes' do
      bike = double(:bike)
      subject.dock_bike(bike)
      expect(subject.release_bike).to eq bike
    end

    it 'releases a working bike' do
      subject.dock_bike(double(:bike))
      expect(subject.release_bike).to be_working
    end

    it 'does not release a broken bike' do
      bike = double(:bike)
      bike.report_broken
      subject.dock_bike(bike)
      subject.dock_bike(double(:bike))
      expect(subject.release_bike).to be_working
    end

    it 'raises error when only broken bikes' do
      bike = double(:bike)
      bike.report_broken
      subject.dock_bike(bike)
      expect{subject.release_bike}.to raise_error "There are no bikes available"
    end

    it 'raises error when no bikes available' do
      expect{subject.release_bike}.to raise_error "There are no bikes available"
    end

  end

  describe '#dock_bike' do

    it {is_expected.to respond_to(:dock_bike).with(1).argument}

    it 'docks a bike' do
     bike = double(:bike)
     expect(subject.dock_bike(bike)).to eq [bike]
    end

    it 'raises error when trying to dock a bike in a full docking station' do
      DockingStation::DEFAULT_CAPACITY.times {subject.dock_bike(double(:bike))}
      bike = double(:bike)
      expect{subject.dock_bike(bike)}.to raise_error "This docking station is full"
    end

    it 'docks any bike even if it is broken' do
      bike = double(:bike)
      bike.report_broken
      expect(subject.dock_bike(bike)).to eq [bike]
    end

  end

  it {is_expected.to respond_to :bikes}

  it 'returns docked bike' do
    bike = double(:bike)
    subject.dock_bike(bike)
    expect(subject.bikes).to eq [bike]
  end

  it 'initializes with a capacity argument' do
    station = DockingStation.new 50
    expect(station.capacity).to eq 50
  end

end
