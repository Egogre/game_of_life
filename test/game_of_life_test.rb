require 'minitest/autorun'
require 'minitest/emoji'
require_relative '../lib/game_of_life'

class GameOfLifeTest < MiniTest::Test

  attr_reader :game

  def setup
    @game = GameOfLife.new
  end

  def test_a_blank_default_board_is_generated
    assert_equal "O O O\nO O O\nO O O", game.board
  end

  def test_a_blank_board_of_arbitrary_size_is_generated
    @game = GameOfLife.new(rows: 3, columns: 4)
    assert_equal "O O O O\nO O O O\nO O O O", game.board
  end

  def test_living_cell_can_be_placed
    game.make_live(row: 0, column: 1)
    assert_equal "O X O\nO O O\nO O O", game.board
  end

  def test_a_living_cell_can_be_killed
    game.make_live(row: 0, column: 1)
    game.make_dead(row: 0, column: 1)
    assert_equal "O O O\nO O O\nO O O", game.board
  end


end
