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

  context '#process_move' do
    let(:player_01) { Player.new({sign: '0', name: 'Batman'}) }
    let(:player_02) { Player.new({sign: 'X', name: 'Superman'}) }
    let(:board) { Board.new }
    subject(:game) { described_class.new({board: board, player_01: player_01, player_02: player_02}) }
    let(:message) { "Please use a number >= 1 to move\n" }

    it 'gets a valid move number, plays it and switches turn' do
      game.process_move('7')
      expect(game.board.grid[2][0]).not_to be_empty
      expect(game.current_player).to eq player_02
    end

    it 'rejects a move number outside the board' do
      game.process_move("56")
      expect(game.error_message).to eq "Please play inside the board\n"
      expect(game.current_player).to eq player_01
    end

    it 'requires numbers greater or equal to 1 for moves (0)' do
      game.process_move('0')
      expect(game.error_message).to eq message
    end

    it 'requires numbers greater or equal to 1 for moves (-2.45)' do
      game.process_move('-2.45')
      expect(game.error_message).to eq message
    end

    it 'requires numbers greater or equal to 1 for moves (nil)' do
      game.process_move(nil)
      expect(game.error_message).to eq message
    end

    it 'requires numbers greater or equal to 1 for moves (:symbol)' do
      game.process_move(:symbol)
      expect(game.error_message).to eq message
    end

    it 'cannot play an occupied field' do
      game.process_move('7')
      game.process_move('7')
      expect(game.error_message).to eq "Cannot play an occupied field\n"
      expect(game.current_player).to eq player_02
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

  context '#translate_into_coords' do
    let(:player_01) { Player.new({sign: '0', name: 'Batman'}) }
    let(:player_02) { Player.new({sign: 'X', name: 'Superman'}) }
    let(:board) { Board.new }
    subject(:game) { described_class.new({board: board, player_01: player_01, player_02: player_02}) }

    it 'gets the move number from the player and converts it into grid coordinates' do
      expect(game.translate_into_coords(9)).to eq [2, 2]
    end
  end
end
