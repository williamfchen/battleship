require "./lib/ship"
require "./lib/cell"
require "./lib/board"

RSpec.describe Board do
  before(:each) do
    @board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
  end

  describe "#initialize" do
    it "can initialize" do
      expect(@board).to be_an_instance_of(Board)
    end
    
    it "has readable attributes" do
      expect(@board.cells).to be_a Hash
    end
  end
  
  describe "#valid_coordinate?" do
    it "can determine if a coordinate is within the board's boundaries" do
      expect(@board.valid_coordinate?("A1")).to be true
      expect(@board.valid_coordinate?("D4")).to be true
      expect(@board.valid_coordinate?("A5")).to be false
      expect(@board.valid_coordinate?("E1")).to be false
      expect(@board.valid_coordinate?("A22")).to be false
    end
  end

  describe "#valid_palcement?" do
    xit "can determine if a ship is placed properly on the board" do
      expect(@board.valid_placement?(@cruiser, ["A1", "A2"])).to be false
      expect(@board.valid_placement?(@submarine, ["A2", "A3", "A4"])).to be false

      expect(@board.valid_placement?(@cruiser, ["A1", "A2", "A4"])).to be false
      expect(@board.valid_placement?(@submarine, ["A1", "C1"]).to be false)
      expect(@board.valid_placement?(@cruiser, ["A3", "A2", "A1"])).to be false
      expect(@board.valid_placement?(@submarine, ["C1", "B1"]).to be false)

      expect(@board.valid_placement?(@cruiser, ["A1", "B2", "C3"])).to be false
      expect(@board.valid_placement?(@submarine, ["C2", "D3"])).to be false

      expect(@board.valid_placement?(@submarine, ["A1", "A2"])).to true
      expect(@board.valid_placement?(@cruiser, ["B1", "C1", "D1"])).to true
    end
  end

  describe "#consecutive" do
    it "can determine if the coordinates for placement are consecutive or not" do
      expect(@board.consecutive?(["A1", "A2", "A4"])).to be false
      expect(@board.consecutive?(["A1", "C1"])).to be false
      expect(@board.consecutive?(["A3", "A2", "A1"])).to be false
      expect(@board.consecutive?(["C1", "B1"])).to be false
      expect(@board.consecutive?(["A1", "A2", "A3"])).to be true
    end
  end

end