require 'game'

describe Game do
  context '#initialize' do
    let(:player_01) { Player.new({sign: '0', name: 'Batman'}) }
    let(:player_02) { Player.new({sign: 'X', name: 'Superman'}) }
    let(:board) { Board.new }
    subject(:game) { described_class.new({board: board, player_01: player_01, player_02: player_02}) }

    it 'starts with two players and a board' do
      expect(game.current_player).to eq player_01
      expect(game.opposing_player).to eq player_02
      expect(game.board).to eq board
    end

    it 'requires two Player objects for players' do
      expect { described_class.new({player_01: 'A non-player', player_02: player_02, board: board}) }.to raise_error 'Two actual players are needed to start a game'
    end

    it 'requires a Board object for the board' do
      expect { described_class.new({player_01: player_01, player_02: player_02, board: nil}) }.to raise_error 'An actual board is needed to start a game'
    end
  end

  context '#ask_for_move' do
    let(:player_01) { Player.new({sign: '0', name: 'Batman'}) }
    let(:player_02) { Player.new({sign: 'X', name: 'Superman'}) }
    let(:board) { Board.new }
    subject(:game) { described_class.new({board: board, player_01: player_01, player_02: player_02}) }

    it 'asks the current player to make a move' do
      expect(game.ask_for_move).to eq "Batman, please move: 1-9, horizontally, from upper-left corner"
    end
  end

  context '#get_coord' do
    let(:player_01) { Player.new({sign: '0', name: 'Batman'}) }
    let(:player_02) { Player.new({sign: 'X', name: 'Superman'}) }
    let(:board) { Board.new }
    subject(:game) { described_class.new({board: board, player_01: player_01, player_02: player_02}) }

    it 'gets the move number from the player and converts it into grid coordinates' do
      expect(game.get_coord("5")).to eq [1, 1]
    end

    it 'only accepts moves within the board' do
      expect { game.get_coord("12") }.to raise_error 'Please move within the board'
    end

    it 'requires numbers greater or equal to 1 for moves' do
      expect { game.get_coord("0") }.to raise_error 'Please use a number >= 1 to move'
      expect { game.get_coord("-2.45") }.to raise_error 'Please use a number >= 1 to move'
      expect { game.get_coord(nil) }.to raise_error 'Please use a number >= 1 to move'
      expect { game.get_coord(:symbol) }.to raise_error 'Please use a number >= 1 to move'
    end
  end

  context '#switch' do
    let(:player_01) { Player.new({sign: '0', name: 'Batman'}) }
    let(:player_02) { Player.new({sign: 'X', name: 'Superman'}) }
    let(:board) { Board.new }
    subject(:game) { described_class.new({board: board, player_01: player_01, player_02: player_02}) }

    it 'switches turns' do
      game.switch
      expect(game.current_player).to eq player_02
      expect(game.opposing_player).to eq player_01
    end
  end
end
