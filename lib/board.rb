class Board
  EMPTY_FIELD = ""
  attr_reader :grid

  def initialize(size = 3)
    raise 'No fun if board is smaller than 3x3' if size < 3
    raise 'Be a sport and provide an integer for size' if !size.is_a? Integer
    @grid = Array.new(size) { Array.new(size) { EMPTY_FIELD } }
  end

  def set_field(args)
    @grid[args.fetch(:row)][args.fetch(:col)] = args.fetch(:val)
  end

  def get_field(args)
    @grid[args.fetch(:row)][args.fetch(:col)]
  end

end
