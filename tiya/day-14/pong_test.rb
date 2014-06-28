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

  def test_lead_by_2
    game=Game.new
    game.record_winner_of_point(:bill)
    10.times do
      game.record_winner_of_point(:ted)
    end
    assert_equal true, game.lead_by_2?
  end

  def test_lead_by_2_negative
    game=Game.new
    game.record_winner_of_point(:ted)
    10.times do
      game.record_winner_of_point(:bill)
    end
    assert_equal true, game.lead_by_2?
  end

  def test_21_lead_by_2
    game=Game.new
    game.record_winner_of_point(:bill)
    21.times do
      game.record_winner_of_point(:ted)
    end
    assert_equal :ted , game.run
  end

  def test_over_21_lead_by_2
    game=Game.new
    game.record_winner_of_point(:bill)
    22.times do
      game.record_winner_of_point(:ted)
    end
    assert_equal true , game.enough_to_win?
  end

end
