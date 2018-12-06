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

  describe "#touch_in" do

    it "it won't touch in if balance is too low" do
      expect{ card.touch_in(entry_station, zone) }.to raise_error "Your balance is too low"
    end

  end

  describe "#touch_out" do

    it 'charges minimum fare when touched out' do
      card.top_up(Journey::MINIMUM_FARE)
      card.touch_in(entry_station, zone)
      expect{ card.touch_out(exit_station, zone) }.to change{ card.balance }.by -(Journey::MINIMUM_FARE)
    end
  end

  describe "#journey" do

    before(:each) do
      allow(card).to receive(:top_up).and_return(Journey::MINIMUM_FARE)
    end

    it 'records a completed journey' do
      expect(journey).to eq([entry_station: entry_station, exit_station: exit_station])
    end

    # it 'stores a journey' do
    #   card = Oystercard.new
    #   card.top_up(20)
    #   card.touch_in('Kings Cross', 2)
    #   card.touch_out('Makers', 4)
    #   expect(card.journey_history).to eq([[{:entry_station=>'Kings Cross', :zone=>2}, {:exit_station=>'Makers', :zone=>4}]])
    # end

  end

end
