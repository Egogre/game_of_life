require 'pry'
class GameOfLife

  attr_reader :cells

  def initialize(options={})
    rows = options[:rows] || 3
    cols = options[:columns] || 3
    generate(rows, cols)
  end

  def board
    cells.collect {|row| row.join(' ')}.join("\n")
  end

  def generate(rows, cols)
    @cells = Array.new(rows, Array.new(cols))
    cells.each_with_index do |row, i|
      row.each_index do |j|
        cells[i][j] = "O"
      end
    end
  end

end
