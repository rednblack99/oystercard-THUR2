require "oystercard"

describe Oystercard do

subject(:card) { Oystercard.new }
let(:entry_station) { double :entry_station }
let(:exit_station) { double :exit_station }

  it "it starts with a balance of zero" do
    expect(card.balance).to eq(0)
  end

  it 'starts with an empty journey array' do
    expect(card.journeys).to eq({})
  end

  describe "#top_up" do

    it "it should be able to top up by a given amount" do
      expect{ card.top_up(5) }.to change{ card.balance }.by 5
    end

    it "it should prevent user form having a balance higher than #{Oystercard::MAXIMUM_BALANCE}" do
      max_bal = Oystercard::MAXIMUM_BALANCE
      card.top_up(max_bal)
      expect { card.top_up(1) }.to raise_error "Balance has exceeded maximum balance of £#{max_bal}"
    end

  describe '#in_journey?' do
    it "should return nil or entry_station name" do
      expect(card.in_journey?).to eq(true).or be_falsey
    end
  end

  describe "#touch_in" do
    it "it won't touch in if balance is too low" do
      expect{ card.touch_in(entry_station) }.to raise_error "Your balance is too low"
    end

    it "it records point of entry entry_station" do
      card.top_up(Oystercard::MINIMUM_FARE)
      expect(card.touch_in(entry_station)).to eq(entry_station)
    end

  end

  describe "#touch_out" do
    it "it records touch out exit_station" do
      card.top_up(Oystercard::MINIMUM_FARE)
      card.touch_in(entry_station)
      expect(card.touch_out(exit_station)).to be(exit_station)
    end

    # it 'can touch out' do
    #   expect(card.touch_out).to eq(false)
    # end

    it 'charges minimum fare when touched out' do
      card.top_up(Oystercard::MINIMUM_FARE)
      card.touch_in(entry_station)
      expect{ card.touch_out(exit_station) }.to change{ card.balance }.by -(Oystercard::MINIMUM_FARE)
    end
  end
end
end
