# frozen_string_literal: true

class Board
  attr_accessor :board
  def initialize
    @board = Array.new(8, Array.new(8))
  end
end

# class for Knight
class Knight
  attr_reader :position, :parent

  # available moves
  MOVES = [[-2, 1], [-2, -1], [-1, 2], [-1, -2],[1, 2], [1, -2], [2, 1], [2, -1]]
  @@visited_cells = []

  def initialize(position, parent = nil)
    @@visited_cells << position
    @position = position
    @parent = parent
  end

  # validation of move (check if it's inside the 8x8 board)
  def valid_move?(pos)
    pos[0].between?(0, 7) && pos[1].between?(0, 7)
  end

  # building vertecies from possible moves
  def child_vertecies
    moves = MOVES.map { |move| [@position[0] + move[0], @position[1] + move[1]]}
      .delete_if { |move| @@visited_cells.include?(move)}
      .keep_if { |move| valid_move?(move)}
      .map { |move| Knight.new(move, self)}
  end
end

def knight_moves(start, target)
  vertex = Knight.new(start)
  q = []
  result = []
  until vertex.position == target
    vertex.child_vertecies.each { |vertex| q << vertex} 
    vertex = q.shift
  end
  until vertex.parent.nil?
    result << vertex.position
    vertex = vertex.parent
  end
  result << vertex.position
  puts "Number of moves from #{start} to #{target}: #{result.length - 1}"
  result.reverse.each_with_index {|move, index| 
    unless index == result.length - 1 
      print "#{move} -> " 
    else
      print "#{move}"
    end}
  puts
end

# method that takes 2 argument, start [x,y] end [x,y]
# and gives back the shortest path from start to end

knight_moves([0, 0], [5, 5])
