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

    # columns = coordinates.map do |coor|
    #   coor[0]
    # end
    
    # columns
  end

  # split letters and nums and throw math into to make sure 
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
      # chars_array.each_cons
    # end

  end
  # look into each_cons method
  # if the coordinate letters are the same, then check if the nums are the in order. Use the value of the nums to make sure the NEXT value in the array is == to the current +1

  # if the nums are the same, check to make sure the letters are in order. utiliizee .ord to make sure the NEXT value in the array is == to the current +1

    # need to make sure that they're all in series with one another 
end