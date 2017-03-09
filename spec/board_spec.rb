require 'spec_helper'
require 'board'

describe Board do
  context '#initialize' do
    it 'starts as a default 3x3 square with empty fields' do
      board = Board.new
      expect(board.grid).to be_instance_of(Array)
      expect(board.grid.length).to eq 3
      board.grid.each do |row|
        expect(row).to be_instance_of(Array)
        expect(row.length).to eq 3
      end
    end

    it 'can have other sizes, too' do
      board = Board.new(4)
      board.grid.each do |row|
        expect(row).to be_instance_of(Array)
        expect(row.length).to eq 4
      end
    end

    it 'cannot have sizes smaller than 3, though' do
      expect { Board.new(2) }.to raise_error 'No fun if board is smaller than 3x3'
    end

    it 'only takes integers for size' do
      expect { Board.new(5.3) }.to raise_error 'Be a sport and provide an integer for size'
    end
  end

  context '#set_field' do
    it 'can "write" into a field by coordinates' do
      board = Board.new
      board.set_field({row: 1, col: 1, val: "X"})
      expect(board.grid).to eq [["", "", ""], ["", "X", ""], ["", "", ""]]
    end

    it 'cannot "write" into an occupied field' do
      board = Board.new
      board.set_field({row: 1, col: 1, val: "X"})
      expect { board.set_field({row: 1, col: 1, val: "0"}) }.to raise_error 'Cannot play an occupied field'
    end

    it 'only accepts moves within the board' do
      board = Board.new
      expect { board.set_field({row: 4, col: 2, val: "X"}) }.to raise_error 'Please move within the board'
    end

    it 'only accepts non-negative integers for coordinates' do
      board = Board.new
      message = 'Please use non-negative integers for coordinates'
      expect { board.set_field({row: -1, col: 2, val: "X"}) }.to raise_error message
      expect { board.set_field({row: 1, col: -2.45, val: "X"}) }.to raise_error message
      expect { board.set_field({row: nil, col: 2, val: "X"}) }.to raise_error message
      expect { board.set_field({row: :symbol, col: 2, val: "X"}) }.to raise_error message
    end
  end

  context '#get_field' do
    it 'can "read" from a field by coordinates' do
      board = Board.new
      board.set_field({row: 1, col: 1, val: "X"})
      expect(board.get_field({row: 1, col: 1})).to eq "X"
    end
  end

  context '#show' do
    it 'prints the board to the console' do
      board = Board.new
      board.set_field({row: 1, col: 1, val: "X"})
      expect(board.show).to eq " | | \n- - -\n |X| \n- - -\n | | \n"
    end
  end
end
