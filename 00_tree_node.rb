class PolyTreeNode
  attr_reader :parent, :children, :value

  def initialize(value, parent = nil)
    @parent = parent
    @children = []
    @value = value
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

  def dfs(target)
    return self if @value == target
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
