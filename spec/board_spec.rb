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
      expect(@board.cells).to eq({...})
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
end