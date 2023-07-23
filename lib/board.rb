class Board
  attr_reader :cells

  def initialize
    @cells = create_cells
  end

  def create_cells
    cells = {}
    ("A".."D").each do |letter|
      (1..4).each do |num|
        coordinate = "#{letter}#{num}"
        cells[coordinate] = Cell.new(coordinate)
      end
    end
    cells
  end

  def valid_coordinate?(coordinate)
    cells.key?(coordinate)
  end

  def valid_placement?(ship, coordinates)
    return false unless ship.is_a?(Ship) && coordinates.is_a?(Array) && coordinates.length == ship.length

    
  end
end