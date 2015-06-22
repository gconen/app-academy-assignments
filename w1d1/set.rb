class MyHashSet
  attr_reader :store

  def initialize(store = {})
    @store = store
  end

  def insert(el)
    @store[el] = true
  end

  def include?(el)
    if @store[el]
      return true
    else
      return false
    end
  end

  def delete(el)
    if include?(el)
      @store.delete(el)
      return true
    else
      return false
    end
  end

  def to_a
    @store.keys
  end

  def union(other_set)
    MyHashSet.new(@store.merge(other_set.store))
  end

  def inspect
    @store.inspect
  end

  def intersect(set2)
    new_set = MyHashSet.new
    @store.each do |key, value|
      if set2.include?(key)
        new_set.insert(key)
      end
    end
    new_set
  end

  def minus(set2)
    new_set = MyHashSet.new
    @store.each do |key, value|
      unless set2.include?(key)
        new_set.insert(key)
      end
    end
    new_set
  end
end

set1 = MyHashSet.new
set1.insert(1)
set1.insert(2)
set1.insert(3)

set2 = MyHashSet.new
set2.insert(3)
set2.insert(4)
set2.insert(5)


p set1.delete(5)
p set1
