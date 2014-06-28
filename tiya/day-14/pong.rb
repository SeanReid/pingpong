require 'pry'

class Game

  def initialize
    @points = {}
  end

  def record_winner_of_point(player)
    @points[player] ||= 0
    @points[player] += 1
  end

  def lead_by_2?
    lead_by = @points[:bill] - @points[:ted]
    if lead_by >= 2 || lead_by <= -2
      return true
    else
      return false
    end
  end

  def full_game?
    if @points[:bill] >= 21 || @points[:ted] >= 21
      return true
    else
      return false
    end
  end

  def winner
    if @points[:bill] > @points[:ted]
      return :bill
    else
      return :ted
    end
  end

  def run
    full_game?
    lead_by_2?
    winner
  end

end
