require 'minitest/autorun'
require 'minitest/emoji'
require_relative '../lib/game_of_life'

class GameOfLifeTest < MiniTest::Test

  attr_reader :game

  def setup
    @game = GameOfLife.new
  end

  def test_a_blank_default_board_is_generated
    assert_equal "     \n     \n     ", game.board
  end

  def test_a_blank_board_of_arbitrary_size_is_generated
    @game = GameOfLife.new(rows: 3, columns: 4)
    assert_equal "       \n       \n       ", game.board
  end

  def test_living_cell_can_be_placed
    game.make_live(row: 0, column: 1)
    assert_equal "  X  \n     \n     ", game.board
  end

  def test_a_living_cell_can_be_killed
    game.make_live(row: 0, column: 1)
    game.make_dead(row: 0, column: 1)
    assert_equal "     \n     \n     ", game.board
  end

  def test_a_cell_can_be_queried
    game.make_live(row: 0, column: 1)
    assert game.alive?(row: 0, column: 1)
    refute game.alive?(row: 0, column: 2)
  end

  def test_game_can_be_given_starting_conditions
    game.populate(cells: [{row:0, column:1}, {row:1, column:0}, {row:2, column:1}])
    assert_equal "  X  \nX    \n  X  ", game.board
  end

  def test_game_can_be_randomly_populated
    @game = GameOfLife.new(rows:100, columns:100)
    start = game.board
    game.randomize_board
    refute_equal start, game.board
  end

  def test_game_can_be_cleared
    @game = GameOfLife.new(rows:100, columns:100)
    start = game.board
    game.randomize_board
    game.clear
    assert_equal start, game.board
  end

  def test_out_of_bounds_raises_error
    assert_raises(ArgumentError) {game.make_live(row: 5, column: 5)}
    assert_raises(ArgumentError) {game.make_live(row: -5, column: -1)}
    assert_raises(ArgumentError) {game.make_dead(row: 5, column: 5)}
    assert_raises(ArgumentError) {game.make_dead(row: -5, column: -5)}
  end

  def test_game_cycles_correctly
    game.populate(cells: [{row:0, column:2}, {row:1, column:0}, {row:2, column:1}])
    game.cycle
    assert_equal "     \n  X  \n     ", game.board
    game.cycle
    assert_equal "     \n     \n     ", game.board
  end

  def test_game_cycles_correctly_again
    game.populate(cells: [{row:0, column:0}, {row:0, column:1}, {row:1, column:0}, {row:1, column:1}])
    game.cycle
    assert_equal "X X  \nX X  \n     ", game.board
    game.cycle
    assert_equal "X X  \nX X  \n     ", game.board
  end

  def test_game_knows_when_board_is_stable
    assert game.stable?
    game.make_live(row: 1, column: 1)
    refute game.stable?
  end

  def test_game_knows_when_board_is_stable_again
    game.populate(cells: [{row:0, column:0}, {row:0, column:1}, {row:1, column:0}, {row:1, column:1}])
    assert game.stable?
  end

  def test_game_knows_when_board_is_in_loop
    game.populate(cells: [{row:0, column:1}, {row:1, column:1}, {row:2, column:1}])
    assert game.stable?
  end

end
