require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    val = prc.call(key)
    eject! if count >= @max

    # Add Node to Hash and LinkedList
    @store.append(key,val)
    @map.set(key,val)
  end



  def update_node!(node)
    # suggested helper method; move a node to the end of the list
    new_last = @store.last

  end

  def eject!
    garbage_node = @store.first
    head = garbage_node.prev 
    new_first = garbage_node.next
    head.next = new_first
    new_first.prev = head

    @map.delete(garbage_node.key)
  end
end
