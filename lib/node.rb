class Node
  include Comparable
  attr_accessor :left, :right, :data

  def initialize(data = nil)
    @data = data
    @left = nil
    @right = nil
  end

  def <=>(other)
    data <=> other.data
  end

  def <(other)
    data < other.data
  end

  def >(other)
    data > other.data
  end

  def ==(other)
    data == other.data
  end

  def between?(first, second)
    data.between?(first.data, second.data)
  end
end
