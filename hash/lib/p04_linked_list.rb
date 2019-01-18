class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = tail
    @tail.prev = head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    head.next unless head.next == tail
  end

  def last
    tail.prev unless tail.prev == head
  end

  def empty?
    head.next == tail && tail.prev == head
  end

  def get(key)
    each do |node|
      return node.val if node.key == key
    end
  end

  def include?(key)
    each do |node|
      return true if node.key == key
    end
    false
  end

  def append(key, val)
    new_node = Node.new(key, val)
    last_node = tail.prev
    
    last_node.next = new_node
    new_node.prev = last_node
    new_node.next = tail
    tail.prev = new_node
  end

  def update(key, val)
      each do |node|
        node.val = val if node.key == key
      end
  end

  def remove(key)
    each do |node|
      if node.key == key
        last_node = node.prev
        next_node = node.next
    
        last_node.next = next_node
        next_node.prev = last_node
      end
    end
  end

  def each(&prc)
    curr_node = head.next
    until curr_node == tail
      prc.call(curr_node)
      curr_node = curr_node.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end

  private
  attr_reader :head, :tail
end
