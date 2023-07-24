class Board
  attr_reader :cells

  def initialize
    @cells = create_cells
  end

  def create_cells
    cells= {}
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

  def place(ship, coordinates)
      coordinates.each { |coordinate| cells[coordinate].place_ship(ship) } #if valid_placement?
  end

  def render(reveal_ships = false)
    board_render = "  " + ('A'..'D').to_a.join(" ") + "\n"
    ("1".."4").each do |row|
      board_render += row + " "
      ("A".."D").each do |column|
        coordinate = "#{column}#{row}"
        cell = cells[coordinate]
        board_render += cell.render(reveal_ships) + " "
      end
      board_render += "\n"
    end
    puts board_render
  end
end