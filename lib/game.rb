require_relative 'ship'
require_relative 'cell'
require_relative 'board'

class Game
  def initialize
    @player_board = Board.new
    @computer_board = Board.new
    @targeting_mode = false
    @last_hit = nil
  end
  
  def start
    system("clear")
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
    loop do
      system("clear")
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
      break unless play_again?  
    end
  end

  def play_again?
    puts "Do you want to play again? (p/q):"
    input = gets.chomp.downcase
    exit if input == "q"
    if input == "p"
      new_game = Game.new
      new_game.start
    end
  end

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
    if @computer_board.valid_coordinate?(coordinate) && !@computer_board.cells[coordinate].fired_upon?
      @computer_board.cells[coordinate].fire_upon
      if @computer_board.cells[coordinate].empty?
        system("clear")
        miss = File.open("./lib/ascii_art/miss.txt")
        puts miss.read
      else
        system("clear")
        if @computer_board.cells[coordinate].ship.sunk?
          puts "You sunk their battleship!"
          sunk = File.open("./lib/ascii_art/sunk.txt")
          puts sunk.read  
        else
          hit = File.open("./lib/ascii_art/hit.txt")
          puts hit.read
        end
      end
    elsif @computer_board.valid_coordinate?(coordinate) && @computer_board.cells[coordinate].fired_upon?
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
    @computer_board.render
    puts "\n" + "=======Player Board======="
    @player_board.render(true)
  end
  
  def computer_turn
    sleep(0.8)
    puts "Computer's Turn:"

    coordinate = nil
    # loop do
    #   coordinate = generate_random_coordinate
    #   break if @player_board.valid_coordinate?(coordinate) && !@player_board.cells[coordinate].fired_upon?
    # end

    if @targeting_mode == true
      adjacent_cells = find_adjacent(@last_hit)
      coordinate = adjacent_cells.sample unless adjacent_cells.empty?
      @targeting_mode = false if coordinate.nil? || @player_board.cells[coordinate].fired_upon? || (@player_board.cells[coordinate].ship && @player_board.cells[coordinate].ship.sunk?)    
    else
      loop do
        coordinate = generate_random_coordinate
        break if @player_board.valid_coordinate?(coordinate) && !@player_board.cells[coordinate].fired_upon?
      end
      # coordinate = generate_random_coordinate
    end
    
    if !@player_board.cells[coordinate].fired_upon?
      @player_board.cells[coordinate].fire_upon
      if @player_board.cells[coordinate].empty?
        puts "Computer fired at #{coordinate} and missed!"
        sleep(0.5)
      else
        if @player_board.cells[coordinate].ship.sunk?
          puts "Computer sunk your battleship!"
          sunk = File.open("./lib/ascii_art/sunk.txt")
          puts sunk.read 
          @targeting_mode = false
        else
          puts "Computer hit your ship at #{coordinate}!"
          @targeting_mode = true
          @last_hit = coordinate
          danger = File.open("./lib/ascii_art/danger.txt")
          puts danger.read if @computer_board.all_ships_sunk?
        end
        sleep(0.8)
      end
    end
  end

  def generate_random_coordinate
    @player_board.cells.keys.sample
  end

  def find_adjacent(coordinate)
    letter = coordinate[0]
    number = coordinate[1].to_i
    adjacent_cells = []

    if number > 1
      adjacent_coordinate = "#{letter}#{number - 1}"
      adjacent_cells << adjacent_coordinate if @player_board.valid_coordinate?(adjacent_coordinate) && !@player_board.cells[adjacent_coordinate].fired_upon?
    end
    if number < 8
      adjacent_coordinate = "#{letter}#{number + 1}"
      adjacent_cells << adjacent_coordinate if @player_board.valid_coordinate?(adjacent_coordinate) && !@player_board.cells[adjacent_coordinate].fired_upon?
    end
    if letter.ord > 65
      adjacent_coordinate = "#{(letter.ord - 1).chr}#{number}"
      adjacent_cells << adjacent_coordinate if @player_board.valid_coordinate?(adjacent_coordinate) && !@player_board.cells[adjacent_coordinate].fired_upon?
    end
    if letter.ord < 74
      adjacent_coordinate = "#{(letter.ord + 1).chr}#{number}"
      adjacent_cells << adjacent_coordinate if @player_board.valid_coordinate?(adjacent_coordinate) && !@player_board.cells[adjacent_coordinate].fired_upon?
    end
    adjacent_cells
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