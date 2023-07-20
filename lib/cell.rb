class Cell
  attr_reader :coordinate, :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fired_upon = false
  end

  def empty?
    @ship.nil?
  end

  def place_ship(boat)
    @ship = boat
  end

  def fired_upon?
    @fired_upon
  end

  def fire_upon
    @fired_upon = true
  end

  def render(reveal_ship = false)
    if fired_upon?
      return "M" if empty?
      return "X" if ship.sunk?
      return "H"
    end
    return "S" if reveal_ship && !empty?
    "."
  end
end
