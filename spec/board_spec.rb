require 'spec_helper'
require 'board'

describe Board do
  context '#initialize' do
    it 'starts as a default 3x3 square with empty fields' do
      board = Board.new
      expect(board.grid).to eq [["", "", ""], ["", "", ""], ["", "", ""]]
    end

    it 'can have other sizes, too' do
      board = Board.new(4)
      expect(board.grid).to eq [["", "", "", ""], ["", "", "", ""], ["", "", "", ""], ["", "", "", ""]]
    end

    it 'cannot have sizes smaller than 3, though' do
      expect { Board.new(2) }.to raise_error 'No fun if board is smaller than 3x3'
    end

    it 'only takes integers for size' do
      expect { Board.new(5.3) }.to raise_error 'Be a sport and provide an integer for size'
    end
  end
end
