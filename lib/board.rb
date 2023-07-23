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

    return false unless coordinates.all? do |coor|
      valid_coordinate?(coor)
    end

    columns = coordinates.map do |coor|
      coor[0]
    end
    
    columns
  end

  def consecutive?
    # split letters and nums and throw math into to make sure 
  end

    # valid_horizontal =
    # valid_veritcal = 
    # valid_horizontal || valid_veritcal

    # need to make sure that they're all in series with one another 
end