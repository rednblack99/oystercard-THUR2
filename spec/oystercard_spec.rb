require "oystercard"

describe Oystercard do

  subject(:card) { Oystercard.new }
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }
  let(:journey){ [{entry_station: entry_station, exit_station: exit_station}] }
  let(:zone) { double :zone }

  describe "#top_up" do

    it "increases starting balance of 0 by a given amount" do
      expect{ card.top_up(5) }.to change{ card.balance }.by 5
    end

    it "it prevents user form having a balance higher than #{Oystercard::MAXIMUM_BALANCE}" do
      max_bal = Oystercard::MAXIMUM_BALANCE
      card.top_up(max_bal)
      expect { card.top_up(1) }.to raise_error "Balance has exceeded maximum balance of £#{max_bal}"
    end

  end

  describe '#in_journey?' do

    it "card set as nil if not in journey" do
      expect(card.in_journey?).to eq(true).or be_falsey
    end

  end

  describe "#touch_in" do

    it "it won't touch in if balance is too low" do
      expect{ card.touch_in(entry_station, zone) }.to raise_error "Your balance is too low"
    end

  end

  describe "#touch_out" do

    it 'charges minimum fare when touched out' do
      card.top_up(Oystercard::MINIMUM_FARE)
      card.touch_in(entry_station, zone)
      expect{ card.touch_out(exit_station, zone) }.to change{ card.balance }.by -(Oystercard::MINIMUM_FARE)
    end
  end

  describe "#journey" do

    before(:each) do
      allow(card).to receive(:top_up).and_return(Oystercard::MINIMUM_FARE)
      # allow(card).to receive(:touch_in).and_return(entry_station, zone)
      # allow(card).to receive(:touch_out).and_return(exit_station, zone)
    end

    it 'records a completed journey' do
      expect(journey).to eq([entry_station: entry_station, exit_station: exit_station])
    end

    it 'stores a journey' do
      journey_card = Oystercard.new
      journey_card.top_up(20)
      journey_card.touch_in("entry_station", 1)
      journey_card.touch_out("exit_station", 2)
      expect(journey_card.journeys).to eq([[{:entry_station=>"entry_station", :zone=>1}, {:exit_station=>"exit_station", :zone=>2}]])
    end

  end

end
