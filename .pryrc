require './lib/game'
require './lib/player'
require './lib/board'
player_01 = Player.new({sign: 'X', name: 'Batman'})
player_02 = Player.new({sign: 'O', name: 'Superman'})
board = Board.new
game = Game.new({board: board, player_01: player_01, player_02: player_02})
