class Board
  EMPTY_FIELD = ""
  attr_reader :grid

  def initialize(size = 3)
    raise 'No fun if board is smaller than 3x3' if size < 3
    raise 'Be a sport and provide an integer for size' if !size.is_a? Integer
    @grid = Array.new(size) { Array.new(size) { EMPTY_FIELD } }
  end

  def set_field(args)
    row = args.fetch(:row)
    col = args.fetch(:col)
    raise 'Please use non-negative integers for coordinates' if row.nil? || col.nil? || row.is_a?(Symbol) || col.is_a?(Symbol) || row < 0 || col < 0

    raise 'Please move within the board' if !(0..(@grid.length - 1)).include?(row.to_i) || !(0..(@grid.length - 1)).include?(col.to_i)

    raise 'Cannot play an occupied field' if !@grid[row.to_i][col.to_i].empty?

    @grid[row.to_i][col.to_i] = args.fetch(:val)
  end

  def get_field(args)
    @grid[args.fetch(:row)][args.fetch(:col)]
  end

  def show
    output = ''
    @grid.each do |row|
      output += row.map { |field| field.empty? ? ' ' : field }.join('|') + "\n" + ('- ' * @grid.length).chop! + "\n"
    end
    output.chomp!(('- ' * @grid.length).chop! + "\n")
  end
end
