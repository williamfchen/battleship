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
    require 'pry';binding.pry
      
    # end
  end



end