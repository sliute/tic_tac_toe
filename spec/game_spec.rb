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
end
