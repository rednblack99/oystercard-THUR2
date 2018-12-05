require 'station'

describe Station do

  before(:each) do
    @station = Station.new("Aldgate", 1)
  end

  it "responds to name" do
    expect(@station.name).to be_truthy
  end


  it "responds to zone" do
    expect(@station.zone).to be_truthy
  end


end
