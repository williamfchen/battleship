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
    xit "can determine if a coordinate is within the board's boundaries" do
      expect(@board.valid_coordinate?("A1")).to be true
      expect(@board.valid_coordinate?("D4")).to be true
      expect(@board.valid_coordinate?("A5")).to be false
      expect(@board.valid_coordinate?("E1")).to be false
      expect(@board.valid_coordinate?("A22")).to be false
    end
  end

  describe '#places ships and renders' do
    before(:each) do
      @board.place(@cruiser, ["A1", "A2", "A3"])
      @cell_1 = @board.cells["A1"]
      @cell_2 = @board.cells["A2"]
      @cell_3 = @board.cells["A3"]
      @submarine = Ship.new("Submarine", 2) 
    end

    it '.place' do
      expect(@cell_1.ship).to eq(@cruiser)
      expect(@cell_2.ship).to eq(@cruiser)
      expect(@cell_3.ship).to eq(@cruiser)
      expect(@cell_3.ship == @cell_2.ship).to be true
    end

    it 'doesnt overlap' do
      # add cell.empty? conditional to valid_placement
      # expect(@board.valid_placement?(@submarine, ["A1", "B1"])).to be false
    end

    it '.renders' do
      @board.render
    end
  end

end