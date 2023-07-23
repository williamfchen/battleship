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

    consecutive?(coordinates)
  end

  def consecutive?(coordinates)
    chars_array = []
    nums_array = []

    coordinates.each do |coor|
      chars_array << coor[0]
      nums_array << coor[1]
    end

    if chars_array.uniq.count == 1
      nums_array.each_cons(2).all? do |num1, num2|
        num1.to_i + 1 == num2.to_i
      end

    elsif nums_array.uniq.count == 1
      chars_array.each_cons(2).all? do |char1, char2|
        char1.ord + 1 == char2.ord
      end

    else
      false
    end
  end
end