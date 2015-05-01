require 'card'
require 'rspec'

describe Card do
  subject(:card) { Card.new(:king, :diamonds) }
  describe "::new" do
    it "initializes suit and value" do
      expect(card.value).to eq(:king)
      expect(card.suit).to eq(:diamonds)
    end

    it "raises an error for invalid suit" do
      expect { Card.new(:king, :wrong) }.to raise_error
    end

    it "raises an error for invalid value" do
      expect { Card.new(:wrong, :diamonds) }.to raise_error
    end
  end

  describe "::suits" do
    it "returns all suits" do
      expect(Card.suits).to contain_exactly(:hearts, :diamonds, :clubs, :spades)
    end
  end

  describe "::values" do
    it "returns all values" do
      expect(Card.values).to contain_exactly(
        :ace,
        :king,
        :queen,
        :jack,
        :ten,
        :nine,
        :eight,
        :seven,
        :six,
        :five,
        :four,
        :three,
        :two
      )
    end
  end

  describe "#==" do
    it "matches suit and value" do
      expect(card).to eq(Card.new(:king, :diamonds))
    end

    it "doesn't match cards of other values" do
      expect(card).to_not eq(Card.new(:ace, :diamonds))
    end

    it "doesn't match cards of other suits" do
      expect(card).to_not eq(Card.new(:king, :clubs))
    end
  end

  describe '#<=>' do
    subject(:seven) { Card.new(:seven, :hearts) }
    subject(:six) { Card.new(:six, :clubs) }
    it "returns 0 for equal values" do
      expect(seven <=> Card.new(:seven, :spades)).to eq(0)
    end

    it "returns 1 when first is greater" do
      expect(seven <=> six).to eq(1)
    end

    it "returns -1 when second is greater" do
      expect(six <=> seven).to eq(-1)
    end
  end
end
