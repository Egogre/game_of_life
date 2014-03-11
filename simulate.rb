require_relative 'lib/game_of_life'

game = GameOfLife.new(rows: 40, columns: 50)
game.randomize_board
game.run
