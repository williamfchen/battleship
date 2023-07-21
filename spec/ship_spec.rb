require "./lib/ship"

RSpec.describe Ship do
  before(:each) do
    @cruiser = Ship.new("Cruiser", 3)
  end
  
  describe "#initialize" do
    it "can initialize" do
      expect(@cruiser).to be_an_instance_of(Ship)
    end

    it "has readable attributes" do
      expect(@cruiser.name).to eq("Cruiser")
      expect(@cruiser.length).to eq(3)
      expect(@cruiser.health).to eq(3)
    end
  end

  describe "#hit" do
    it "can count the number of hits on a ship" do
      expect(@cruiser.health).to eq(3)

      @cruiser.hit
      expect(@cruiser.health).to eq(2)
    end
  end

  describe "#sunk?" do
    it "can determine if a ship has sunk" do
      expect(@cruiser.sunk?).to be false
      @cruiser.hit
      @cruiser.hit
      @cruiser.hit

      expect(@cruiser.sunk?).to be true
    end
  end
end
