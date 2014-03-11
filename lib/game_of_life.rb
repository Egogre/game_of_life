require 'pry'
class GameOfLife

  attr_reader :cells

  def initialize(options={})
    rows = options[:rows] || 3
    cols = options[:columns] || 3
    @cells = generate(rows, cols)
  end

  def board
    cells.collect {|row| row.join(' ')}.join("\n")
  end

  def randomize_board
    cells.each_with_index do |row, i|
      row.each_index do |j|
        test = rand(100)
        cells[i][j] = 'X' if test%5 == 0
      end
    end
  end

  def populate(options)
    options[:cells].each do |pair|
      row = pair[:row]
      column = pair[:column]
      cells[row][column] = 'X'
    end
  end

  def make_live(options={})
    raise_if_invalid(options)
    row = options[:row]
    column = options[:column]
    cells[row][column] = 'X'
  end

  def make_dead(options={})
    raise_if_invalid(options)
    row = options[:row]
    column = options[:column]
    cells[row][column] = ' '
  end

  def alive?(options)
    row = options[:row]
    column = options[:column]
    cells[row][column] == 'X'
  end

  def cycle
    counts = living_neighbors
    cells.each_with_index do |row, i|
      row.each_index do |j|
        update(row: i, column: j, neighbors: counts[i][j])
      end
    end
  end

  def run
    system 'clear' or system 'cls'
    while(true) do
      puts board
      cycle
      system 'clear' or system 'cls'
    end
  end

  def stable?
    future_game = Marshal.load(Marshal.dump(self))
    2.times do
      future_game.cycle
      if self.cells == future_game.cells
        return true
      end
    end
    false
  end

  private

  def generate(rows, cols)
    cells = Array.new(rows) {Array.new(cols)}
    cells.each_with_index do |row, i|
      row.each_index do |j|
        cells[i][j] = " "
      end
    end
    cells
  end

  def raise_if_invalid(options)
    if illegal_row(options[:row]) || illegal_column(options[:column])
      raise ArgumentError, "That cell does not exist"
    end
  end

  def illegal_row(row)
    row > cells.length-1 || row < 0
  end

  def illegal_column(column)
    column > cells.first.length-1 || column < 0
  end

  def living_neighbors
    living_neighbors_count = generate(cells.length, cells.first.length)
    cells.each_with_index do |row, i|
      row.each_index do |j|
        living_neighbors_count[i][j] = num_living_neighbors(row: i, column: j)
      end
    end
    living_neighbors_count
  end

  def num_living_neighbors(options)
    row = options[:row]
    column = options[:column]
    count = 0
    (row-1..row+1).to_a.each do |r|
      (column-1..column+1).to_a.each do |c|
        unless illegal_row(r) || illegal_column(c) || same_cell(row, column, r, c)
          count += 1 if alive?(row: r, column: c)
        end
      end
    end
    count
  end

  def same_cell(row, col, test_row, test_col)
    row == test_row && col == test_col
  end

  def update(options)
    row = options[:row]
    column = options[:column]
    neighbors = options[:neighbors]
    if neighbors < 2
      cells[row][column] = ' '
    elsif neighbors == 3
      cells[row][column] = 'X'
    elsif neighbors > 3
      cells[row][column] = ' '
    end
  end

end
