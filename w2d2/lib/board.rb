require 'byebug'

class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @cups = Array.new(14) { [] }
    @name1 = name1
    @name2 = name2
    place_stones
  end

  def place_stones
    6.times do |idx|
      @cups[idx] = [:stone, :stone, :stone, :stone]
      @cups[idx + 7] = [:stone, :stone, :stone, :stone]
    end
  end

  def valid_move?(start_pos)
    unless start_pos.between?(1, 14)
      raise ArgumentError.new "Invalid starting cup"
      return false
    end
    true
  end

  def make_move(start_pos, current_player_name)
    i = 1
    until @cups[start_pos].empty?
      j = (start_pos + i) % 14
      if j == 6 && current_player_name == @name2
        i += 1
      elsif j == 13 && current_player_name == @name1
        i += 1
      else
        @cups[j] << @cups[start_pos].pop
        i += 1
      end
    end
    end_pos = start_pos + i - 1
    render
    next_turn(end_pos % 14)
  end

  def next_turn(ending_cup_idx)
    if ending_cup_idx == 6 || ending_cup_idx == 13
      # ended on store -- get to choose where to start again
      :prompt
    elsif @cups[ending_cup_idx].count == 1
      # ended on empty cup -- switches players' turns
      :switch
    else
      # ended on cup with stones in it -- automatically starts there
      ending_cup_idx
    end  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    if @cups[0..5].all? { |cup| cup.empty? } ||
      @cups[7..13].all? { |cup| cup.empty? }
      return true
    end
    false
  end

  def winner
    if @cups[6].length > @cups[13].length
      return @name1
    elsif @cups[6] == @cups[13]
      return :draw
    else
      return @name2
    end
  end
end
