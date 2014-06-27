# Scoring
# A match is played best 3 of 5 games (or 4/7 or 5/9). For each game, the first player to reach 11 points wins that game,
# however a game must be won by at least a two point margin.
# A point is scored after each ball is put into play (not just when the server wins the point as in volleyball).
#
# The edges of the table are part of the legal table surface, but not the sides.
#
# Flow of the Match
# Each player serves two points in a row and then switch server. However, if a score of 10-10 is reached in any game,
# then each server serves only one point and then the server is switched.

class Game

  def initialize
    @hits = []
  end

  def hit(point)
    @hits << point
  end

  def score
    index = 0
    score = 0
    15.times do
      score += @hits[index]
    end
    index += 1
    return score
  end

end
