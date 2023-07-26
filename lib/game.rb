require_relative 'ship'
require_relative 'cell'
require_relative 'board'

class Game
  def initialize
    @player_board = Board.new
    @computer_board = Board.new
  end
  
  def start
    title = File.open("./lib/ascii_art/title.txt")
    puts title.read
    puts "Welcome to BATTLESHIP!"
    sleep(0.8)
    puts "Enter p to play. Enter q to quit."
    loop do
      input = gets.chomp
      if input == "p"
        play
      elsif input == "q"
        puts "Goodbye"
        break
      else
        puts "Please enter either p or q"
      end
    end
  end

  def play
    # loop do
      system("clear")
      # puts "===========Computer Board===========\n"
      # @computer_board.render
      puts "The computer has placed their ships, your turn."
      puts "============Player Board============\n"
      @player_board.render(true)
      computer_place_ships
      player_place_ships
      system("clear")
      loop do
        player_turn
        break if game_over?
        computer_turn
        break if game_over?
      end
    #   break unless play_again?  
    # end
  end

  # def play_again?
  #   puts "Do you want to play again? (p/q):"
  #   input = gets.chomp.downcase
  #   return false if input == "q"
  #   input == "p"
  # end

  def player_place_ships
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    ships = [cruiser, submarine]
    ships.each do |ship|
      loop do
        coordinates = get_ship_coordinates(ship)
        system("clear")
        if @player_board.valid_placement?(ship, coordinates)
          @player_board.place(ship, coordinates)
          puts "============Player Board============\n"
          @player_board.render(true)
          break
        else
          puts "Invalid placement. Try again."
        end
      end
    end
  end
  
  def computer_place_ships
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    ships = [cruiser, submarine]
    ships.each do |ship|
      (ships.length - 1).times do
        coordinates = generate_random_coordinates_for_ship(ship) 
        until @computer_board.valid_placement?(ship, coordinates)
          coordinates = generate_random_coordinates_for_ship(ship)
        end
        @computer_board.place(ship, coordinates)
      end
    end
  end

  def generate_random_coordinates_for_ship(ship)
    starting_coor = generate_random_coordinate
    direction = rand(2)
    coordinates = [starting_coor]
    if direction == 0
      (ship.length - 1).times do |i|
        letter = starting_coor[0]
        number = starting_coor[1].to_i + i + 1
        next_coor = "#{letter}#{number}"
        coordinates << next_coor
      end
    elsif direction == 1
      (ship.length - 1).times do
        letter = (starting_coor[0].ord + 1).chr
        number = starting_coor[1]
        next_coor = "#{letter}#{number}"
        coordinates << next_coor
      end
    end
    coordinates
  end

  def get_ship_coordinates(ship)
    puts "Enter #{ship.length} coordinates(e.g. A1) for the #{ship.name}, separated with a space:"
    gets.chomp.upcase.split(" ")
  end

  def player_turn
    full_render
    puts "Where shall we fire, Captain?:"
    coordinate = gets.chomp.upcase
    if @computer_board.valid_coordinate?(coordinate)
      @computer_board.cells[coordinate].fire_upon
      if @computer_board.cells[coordinate].empty?
        system("clear")
        miss = File.open("./lib/ascii_art/miss.txt")
        puts miss.read
      else
        system("clear")
        if @computer_board.cells[coordinate].ship.sunk?
          #ascii???
          puts "You sunk their battleship!"
        else
          hit = File.open("./lib/ascii_art/hit.txt")
          puts hit.read
        end
      end
    elsif @player_board.cells[coordinate].fired_upon?
      system("clear")
      puts "Already fired on that coordinate. Try again."
      player_turn
    else
      system("clear")
      puts "Invalid coordinate. Try again."
      player_turn
    end
  end
  
  def full_render
    puts "=======Computer Board======="
    @computer_board.render(true)
    puts "\n" + "=======Player Board======="
    @player_board.render(true)
  end
  
  def computer_turn
    sleep(0.8)
    # system("clear")
    puts "Computer's Turn:"
    coordinate = generate_random_coordinate
    if !@player_board.cells[coordinate].fired_upon?
      @player_board.cells[coordinate].fire_upon
      # puts "=======Your Board======="
      # @player_board.render(true)
      if @player_board.cells[coordinate].empty?
        puts "Computer missed!"
        sleep(0.5)
      else
        if @player_board.cells[coordinate].ship.sunk?
          #ascii???
          puts "Computer sunk your battleship!"
        else
          #ascii???
          puts "Computer hit your ship!"
        end
        sleep(0.5)
      end
    end
  end

  def generate_random_coordinate
    @player_board.cells.keys.sample
  end

  def game_over?
    return false unless player_won? || computer_won?
    true
  end

  def player_won?
    victory = File.open("./lib/ascii_art/victory.txt")
    puts victory.read if @computer_board.all_ships_sunk?
    @computer_board.all_ships_sunk?
  end

  def computer_won?
    game_over = File.open("./lib/ascii_art/game_over.txt")
    puts game_over.read if @player_board.all_ships_sunk?
    @computer_board.all_ships_sunk?
  end
end