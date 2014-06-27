require 'pry'

class Game

  def initialize
    @points = {}
  end

  def record_winner_of_point(player)
    binding.pry
    @points[player] ||= 0
    @points[player] += 1
  end

  def winner
    if @points[:bill] > @points[:ted]
      return :bill
    else
      return :ted
    end
  end

end

#
# has_value?(value) → true or false click to toggle source
# Returns true if the given value is present for some key in hsh.
#
# h = { "a" => 100, "b" => 200 }
# h.has_value?(100)   #=> true
# h.has_value?(999)   #=> false
