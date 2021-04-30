# frozen_string_literal: true
require 'colorize'

class Board
  attr_accessor :board
  def initialize
    @board = Array.new(8).map {|row| row = Array.new(8)}
  end

  def clean_board
    @board.each_with_index do |row, row_index|
      row.each_with_index do |cell, index|
        if row_index % 2 > 0
          if index % 2 > 0
            @board[row_index][index] = "■".black
          else
            @board[row_index][index] = "■".white
          end
        else
          if index % 2 > 0
            @board[row_index][index] = "■".white
          else
            @board[row_index][index] = "■".black
          end
        end
      end
    end
  end

  def set(pos, sign, color)
    @board[pos[0]][pos[1]] = sign.to_s.colorize(:color => color)
  end

  def draw_result(array)
    clean_board()
    array.each_with_index do |pos, index|
      if index == 0
        color = :red
      elsif index == array.length - 1
        color = :green
      else
        color = :light_blue
      end
      set(pos, index, color)
    end

    @board.reverse.each_with_index do |row, index| 
      print "#{row.length - index} "
      row.each do |cell|
        print "#{cell} "
      end
      puts
    end

    print "  "
    8.times do |num|
      print "#{num + 1} "
    end
    puts
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
  result.reverse
end

# method that takes 2 argument, start [x,y] end [x,y]
# and gives back the shortest path from start to end
steps = knight_moves([0, 0], [6, 5])
board = Board.new
board.draw_result(steps)
