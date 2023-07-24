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
    puts "Enter p to play. Enter q to quit."
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
    #computer_place_ships
    loop do
      player_turn
      break if game_over?

      computer_turn
      break if game_over?
    end
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
  
  def computer_place_ships
  end

  def get_ship_coordinates(ship)
    puts "Enter #{ship.length} coordinates(e.g. A1) for the #{ship.name}, separated with a space:"
    gets.chomp.split(" ")
  end

  def player_turn
    puts "Where shall we fire, Captain?:"
    coordinate = gets.chomp.upcase

    if @computer_board.valid_coordinate?(coordinate) && !@computer_board.cells[coordinate].fired_upon?
      @computer_board.cells[coordinate].fire_upon
      @computer_board.render

      if @computer_board.cells[coordinate].empty?
        puts "Miss!"
      else
        puts "Hit!"
      end
    else
      puts "Invalid or already fired-upon coordinate. Try again."
      player_turn
    end
  end

  def computer_turn
  end

  def game_over?
    if player_won?
      puts "YOU WON"
    elsif computer_won?
      puts "Game Over :("
    end
  end

  def player_won?
    @computer_board.all_ships_sunk?
  end

  def computer_won?
    @player_board.all_ships_sunk?
  end

end

