require 'player'
require 'board'

class Game
  attr_reader :current_player, :opposing_player, :board

  def initialize(args)
    raise 'Two actual players are needed to start a game' unless args.fetch(:player_01).is_a?(Player) && args.fetch(:player_02).is_a?(Player)
    raise 'An actual board is needed to start a game' unless args.fetch(:board).is_a?(Board)
    @current_player = args.fetch(:player_01)
    @opposing_player = args.fetch(:player_02)
    @board = args.fetch(:board)
  end
end
