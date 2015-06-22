require 'rspec'
require 'player'

describe Player do
  subject(:player) { Player.new(1024) }
  describe '::new' do
    it "initializes with a bankroll" do
      expect(player.bankroll).to eq(1024)
    end
  end

  describe "#start_new_round(hand)" do
    let(:hand) { double("hand") }

    it "should assign the hand" do
      player.start_new_round(hand)

      expect(player.hand).to be(hand)
    end

    it "should set the pot contribution to zero" do
      player.start_new_round(hand)

      expect(player.pot_contribution).to eq(0)
    end
  end
end
