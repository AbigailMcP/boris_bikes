require 'docking_station.rb'

describe DockingStation do

  it {is_expected.to respond_to :release_bike}
let(:bike) { double :bike }
  describe '#release_bike' do

    it 'gets a bike from docked bikes' do
      bike = double(:bike, :broken => false)
      subject.dock_bike(bike)
      expect(subject.release_bike).to eq bike
    end

    it 'releases a working bike' do
      bike = double(:bike, :broken => false, :working? => true)
      subject.dock_bike(bike)
      expect(subject.release_bike).to be_working
    end

    it 'raises error when only broken bikes' do
      bike = double(:bike, :broken => true, :report_broken => true)
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
     expect(subject.dock_bike(bike)).to eq [bike]
    end

    it 'raises error when trying to dock a bike in a full docking station' do
      DockingStation::DEFAULT_CAPACITY.times {subject.dock_bike(bike)}
      expect{subject.dock_bike(bike)}.to raise_error "This docking station is full"
    end

    it 'docks any bike even if it is broken' do
      bike = double(:bike, :report_broken => true)
      bike.report_broken
      expect(subject.dock_bike(bike)).to eq [bike]
    end

  end

  it {is_expected.to respond_to :bikes}

  it 'returns docked bike' do
    subject.dock_bike(bike)
    expect(subject.bikes).to eq [bike]
  end

  it 'initializes with a capacity argument' do
    station = DockingStation.new 50
    expect(station.capacity).to eq 50
  end

  it 'gives broken bikes to van' do
    bike = double(:bike, :broken => true, :report_broken => true)
    subject.dock_bike(bike)
    subject.give_broken_bikes
    expect(subject.bikes).to eq []
  end
end
