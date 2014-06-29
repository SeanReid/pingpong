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
    return true if lead_by >= 2 || lead_by <= -2
  end

  def full_game?
    return true if @points[:bill] >= 21 || @points[:ted] >= 21
  end

  def winner
    if full_game?
      if @points[:bill] > @points[:ted]
        return :bill
      else
        return :ted
      end
    end
  end

  def run
    lead_by_2?
    winner
  end

end
