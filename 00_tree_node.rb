class PolyTreeNode
  attr_reader :parent, :children, :value

  def initialize(value, input_parent = nil)
    @children = []
    @value = value
    self.parent = input_parent
  end

  def parent=(node)
    @parent.children.delete(self) if @parent
    @parent = node
    @parent.children << self unless node.nil?
  end

  def add_child(node)
    node.parent = self
  end

  def remove_child(node)
    raise "Bad Child" unless @children.include?(node)
    node.parent = nil
  end

  def trace_path_back
    return [@value] if @parent.nil?
    @parent.trace_path_back << @value
  end

  def dfs(target)
    return self if @value == target
    p @value
    @children.each do |child|
      result = child.dfs(target)
      return result if result
    end
    nil
  end

  def bfs(target)
    queue = [self]
    until queue.empty?
      current = queue.shift
      return current if current.value == target
      queue += current.children
    end
    nil
  end

end
