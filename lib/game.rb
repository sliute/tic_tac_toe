require_relative 'player'
require_relative 'board'

class Game
  attr_reader :current_player, :opposing_player, :board, :error_message

  def initialize(args)
    raise 'Two actual players are needed to start a game' unless args.fetch(:player_01).is_a?(Player) && args.fetch(:player_02).is_a?(Player)
    raise 'An actual board is needed to start a game' unless args.fetch(:board).is_a?(Board)
    @current_player = args.fetch(:player_01)
    @opposing_player = args.fetch(:player_02)
    @board = args.fetch(:board)
    @error_message = ''
  end

  def ask_for_move
    output = @error_message + "#{@current_player.name}, please move: 1-#{@board.grid.length ** 2}, horizontally, from upper-left corner"
  end

  def get_coord(number = gets.chomp)
    raise 'Please use a number >= 1 to move' if number.is_a?(Symbol) || number.to_i <= 0
    raise 'Please move within the board' if !(1..@board.grid.length**2).include?(number.to_i)
    translate_into_coords(number.to_i)
  end

  def process_move(number = gets.chomp)
    if number.is_a?(Symbol) || number.to_i <= 0
      @error_message = "Please use a number >= 1 to move\n"
      puts ask_for_move
    elsif !(1..@board.grid.length**2).include?(number.to_i)
      @error_message = "Please play inside the board\n"
      puts ask_for_move
    elsif @board.grid[translate_into_coords(number.to_i)[0]][translate_into_coords(number.to_i)[1]] != Board::EMPTY_FIELD
      @error_message = "Cannot play an occupied field\n"
      puts ask_for_move
    else
      x, y = translate_into_coords(number.to_i)
      @board.set_field({row: x, col: y, val: @current_player.sign})
      switch
    end
  end

  def switch
    @current_player, @opposing_player = @opposing_player, @current_player
  end

  def play
    puts "It's #{@current_player.name}'s turn.\n"
    while true
      puts
      puts @board.show
      puts
      puts ask_for_move
      process_move
    end
  end

  def translate_into_coords(number)
    row = (number - 1) / @board.grid.length
    number % @board.grid.length != 0 ? col = number % @board.grid.length - 1 : col = @board.grid.length - 1
    [row, col]
  end
end
