require 'rspec'
require 'deck'
require 'game'

describe Game do
  let(:players) { Array.new(3) { double("player") } }

  subject(:game) { Game.new(*players)}
  describe "::new" do
    it "takes players as parameters" do
      expect(game.players).to eq(players)
    end

    it "creates a deck" do
      expect(game.deck).to be_a(Deck)
    end
  end

  describe '#betting_round' do
    it "asks each player to make a move" do
      players.each do |player|
        expect(player).to receive(:make_move).and_return(:check)
      end

      game.betting_round
    end

    it ""
  end
end
