require 'automatically_finalizable'

describe AutomaticallyFinalizable do
  before(:each) do
    class Cat < SQLObject
      #finalize! is not called
    end
  end

  it "creates getter and setter methods" do
    c = Cat.new
    expect(c.respond_to? :something).to be false
    expect(c.respond_to? :name).to be true
    expect(c.respond_to? :id).to be true
    expect(c.respond_to? :owner_id).to be true

    c.name = "Nick Diaz"
    c.id = 209
    c.owner_id = 2
    expect(c.name).to eq 'Nick Diaz'
    expect(c.id).to eq 209
    expect(c.owner_id).to eq 2
  end
end
