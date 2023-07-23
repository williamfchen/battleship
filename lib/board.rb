class Board
  attr_reader :cells

  def initialize
    @cells = create_cells
    # require 'pry';binding.pry
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

  def valid_coordinate?

  end

  def place(ship, coordinates)
    # if valid_placement
      coordinates.each { |coordinate| cells[coordinate].place_ship(ship) }
    # end
  end

  def render(reveal_ships = false)
    board_render = "  " + ('A'..'D').to_a.join(" ") + "\n"
    ('1'..'4').each do |row|
      board_render += row + " " # Add row number
      ('A'..'D').each do |column|
        coordinate = "#{column}#{row}"
        cell = cells[coordinate]
        board_render += cell.render(reveal_ships) + " "
      end
      board_render += "\n"
    end
    puts board_render
  end
end