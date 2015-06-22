require 'rspec'
require 'deck'
require 'card'

describe Deck do
  subject(:deck) { Deck.new }
  describe "::new" do
    it "initializes with 52 cards" do
      expect(deck.cards.length).to eq(52)
    end

    it "has all the cards" do
      Card.suits.product(Card.values).each do |(suit, value)|
        expect(deck.cards).to include(Card.new(value, suit))
      end
    end
  end

  describe "#draw" do
    it "returns the multiple cards" do
      expect(deck.draw(4).length).to eq(4)
    end
    # check how many cards are left in the deck instead
    it "gets shorter as it draws" do
      deck.draw(2)

      expect(deck.cards.length).to eq(50)
    end

    it "returns valid cards" do
      cards = deck.draw(5)

      cards.each do |element|
        expect(element).to be_a(Card)
      end
    end

    it "raises an error if too many cards are drawn" do
      expect {deck.draw(53)}.to raise_error
    end

    it "removes drawn cards from deck" do
      card = deck.draw(1).first

      expect(deck.cards).to_not include(card)
    end
  end

  describe '#shuffle' do
    it "shuffles the deck" do
      other_deck = Deck.new

      expect(deck.cards).to eq(other_deck.cards)
      deck.shuffle
      expect(deck.cards).to_not eq(other_deck.cards)
    end
  end
end
