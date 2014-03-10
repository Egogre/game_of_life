require 'minitest/autorun'
require 'minitest/emoji'
require_relative '../lib/game_of_life'

class GameOfLifeTest < MiniTest::Test

  attr_reader :game

  def test_a_blank_default_board_is_generated
    @game = GameOfLife.new
    assert_equal game.board, "O O O\nO O O\nO O O"
  end

  def test_a_blank_board_of_arbitrary_size_is_generated
    @game = GameOfLife.new(rows: 3, columns: 4)
    assert_equal game.board, "O O O O\nO O O O\nO O O O\nO O O O"
  end

end
