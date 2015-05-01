require 'rspec'
require 'hand'
require 'deck'

describe Hand do
  subject(:hand) { Hand.new }

  describe '::new' do
    it "initializes as empty" do
      expect(hand.cards).to be_empty
    end
  end

  describe '#draw' do
    let(:deck) { Deck.new }

    it "draws five cards from deck" do
      hand.draw(deck)

      expect(deck.cards.length).to eq(47)
    end

    it "adds cards to hand" do
      hand.draw(deck)

      expect(hand.cards.length).to eq(5)
    end
  end

  describe '#beats?' do
    let(:other_hand) { Hand.new }

    let(:straight) do
      [
        Card.new(:ace, :spades),
        Card.new(:king, :diamonds),
        Card.new(:queen, :spades),
        Card.new(:jack, :hearts),
        Card.new(:ten, :clubs)
      ]
    end
    let(:flush) do
      [
        Card.new(:two, :spades),
        Card.new(:four, :spades),
        Card.new(:ten, :spades),
        Card.new(:five, :spades),
        Card.new(:seven, :spades)
      ]
    end

    let(:pair_sixes) {[Card.new(:six, :hearts), Card.new(:six, :clubs)]}
    let(:pair_fours) {[Card.new(:four, :spades), Card.new(:four, :diamonds)]}
    let(:filler) {[
      Card.new(:seven, :spades),
      Card.new(:two, :clubs),
      Card.new(:five, :clubs)
      ]}


    it "correctly wins" do
      hand.cards = flush
      other_hand.cards = straight

      expect(hand.beats?(other_hand)).to be_truthy
    end

    it "correctly loses" do
      hand.cards = straight
      other_hand.cards = flush

      expect(hand.beats?(other_hand)).to be_falsy
    end

    it "compares equal hands by value" do
      hand.cards = filler + pair_sixes
      other_hand.cards = filler[0..1] + pair_fours + [Card.new(:ace, :spades)]

      expect(hand.beats?(other_hand)).to be_truthy
    end

    it "reads high card correctly" do
      hand.cards = filler[0..1] + pair_sixes + [Card.new(:eight, :hearts)]
      other_hand.cards = filler + pair_sixes

      expect(hand.beats?(other_hand)).to be_truthy
    end
  end
end
