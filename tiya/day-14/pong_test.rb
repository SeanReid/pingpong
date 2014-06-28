require 'minitest/autorun'
require 'minitest/pride'
require './pong'

class PongTest < Minitest::Test

  def test_2_player_score
    game=Game.new
    game.record_winner_of_point(:ted)
    21.times do
      game.record_winner_of_point(:bill)
    end
    assert_equal :bill, game.winner
  end

  def test_other_player_wins
    game=Game.new
    game.record_winner_of_point(:bill)
    21.times do
      game.record_winner_of_point(:ted)
    end
    assert_equal :ted, game.winner
  end

  def test_under_21
    game=Game.new
    game.record_winner_of_point(:bill)
    10.times do
      game.record_winner_of_point(:ted)
    end
    assert_equal false, game.full_game?
  end

end
