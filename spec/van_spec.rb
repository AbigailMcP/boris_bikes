require 'van'

describe Van do

let(:bike) {double :bike}
let(:station) {double :station}

  it {is_expected.to respond_to(:collect_broken).with(1).argument}

  it "receives broken bikes from station" do
    bike = double(:bike, :broken => true)
    station = double(:station, :give_broken_bikes => [bike])
    expect(subject.collect_broken(station)).to eq [bike]
  end

  

  it "receives working bikes from garage"
  it "** returns working bikes to station **"
  it "accepts no more than 5 broken bikes from station"
  it "accepts no more than 5 fixed bikes from garage"

end
