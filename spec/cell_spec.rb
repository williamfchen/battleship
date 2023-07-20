require './lib/ship'
require './lib/cell'

RSpec.describe Cell do
  describe 'iteration 1' do
    before(:each) do
      @cell = Cell.new("B4")
      @cruiser = Ship.new("Cruiser", 3)
    end

    it 'exists' do
      expect(@cell).to be_a(Cell)
    end
  
    it 'has readable attributes' do
      expect(@cell.coordinate).to eq("B4")
      expect(@cell.ship).to be nil
    end

    it '.empty?' do
      expect(@cell.empty?).to be true
    end

    it '.place_ship' do
      expect(@cell.ship).to eq(@cruiser)
      expect(@cell.empty?).to be false
    end
  end
end