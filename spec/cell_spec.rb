require './lib/ship'
require './lib/cell'

RSpec.describe Cell do
  describe 'iteration 1' do
    let(:cell) { Cell.new("B4") }
    let(:cruiser) { Ship.new("Cruiser", 3) }

    it 'exists' do
      expect(cell).to be_a(Cell)
    end
  
    it 'has readable attributes' do
      expect(cell.coordinate).to eq("B4")
      expect(cell.ship).to be nil
    end

    it '.empty?' do
      expect(cell.empty?).to be true
    end

    it '.place_ship' do
      expect(cell.ship).to eq(@cruiser)
      expect(cell.empty?).to be false
    end

    it '.fired_upon' do
      expect(cell.fired_upon?).to be false
    end

    it '.fire_upon' do
      cell.fire_upon
      expect(ell.ship.health).to eq(2)
      expect(cell.fired_upon?).to be true
    end
  end
  
  describe "iteration 1.5" do
    it '.render' do
      cell_1 = Cell.new("B4")
      expect(cell_1.render).to eq(".")
      cell_1.fire_upon
      expect(cell_1.render).to eq("M")
      cell_2 = Cell.new("C3")
      cruiser = Ship.new("Cruiser", 3)
      cell_2.place_ship(cruiser)
      expect(cell_2.render).to eq(".")
      expect(cell_2.render(true)).to eq("S")
      cell_2.fire_upon
      expect(cell_2.render).to eq("H")
      expect(cruiser.sunk?).to be false
      cruiser.hit
      cruiser.hit
      expect(cruiser.sunk?).to be true
      expect(cell_2.render).to eq("X")
    end
  end
end