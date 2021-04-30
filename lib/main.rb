# frozen_string_literal: true

# class for Knight
class Knight
  attr_reader :position, :parent

  @@visited_cells = []

  # available moves array
  MOVES = [
    [-2, 1], [-2, -1], [-1, 2], [-1, -2],
    [1, 2], [1, -2], [2, 1], [2, -1]
  ]
  
  def initialize(position, parent)
    @position = position
    @parent = parent
    @level = 0
  end

  # validation of move
  def pos_valid?(pos)
    pos[0].between?(0, 7) && pos[1].between?(0, 7)
  end
  # steps history
end

# method that takes 2 argument, start [x,y] end [x,y]
# and gives back the shortest path from start to end
knight = Knight.new([0,0])
