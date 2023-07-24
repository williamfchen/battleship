require_relative 'ship'
require_relative 'cell'
require_relative 'board'

class Game
  def initialize
    @player_board = Board.new
    @computer_board = Board.new
  end

  def start
    puts "Welcome to BATTLESHIP!"
    puts "Enter p to play. Enter q to quit.\n"
    loop do
      input = gets.chomp
      if input == "p"
        play
      elsif input == "q"
        puts "Goodbye"
      else
        puts "Sorry, please enter either p or q"
      end
    end
  end

  def play
    puts "Computer Board\n"
    @computer_board.render
    puts "Player Board\n"
    @player_board.render(true)
    place_ships
  end

  def place_ships
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    ships = [cruiser, submarine]
    ships.each do |ship|
      loop do
        coordinates = get_ship_coordinates(ship)
        if @player_board.valid_placement?(ship, coordinates)
          @player_board.place(ship, coordinates)
          break
        else
          puts "Invalid placement. Try again."
        end
      end
    end
  end

  def get_ship_coordinates(ship)
    puts "Enter #{ship.length} coordinates for the #{ship.name}, separated with a space:"
    gets.chomp.split(" ")
  end

end

