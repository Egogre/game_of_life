class GameOfLife

  def initialize(options=nil)
    rows = options[:rows] || 3
    cols = options[:columns] || 3
  end

  def board
    "O O O\nO O O\nO O O"
  end

end
