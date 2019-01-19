require_relative 'p04_linked_list'


class HashMap
  include Enumerable
  attr_accessor :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    each do |k,v|
      return true if key == k 
    end
    false
  end

  def set(key, val)
    bucket = @store[key.hash % num_buckets]
    if bucket.include?(key)
      bucket.update(key,val)
    else
      bucket.append(key,val)
      @count += 1
      resize! if count > num_buckets
    end
  end

  def get(key)
    each do |k, v|
      return v if key == k
    end
    nil
  end

  def delete(key)
    index = key.hash % num_buckets
    ll = @store[index]
    ll.each do |node|
      if node.key == key
        @count -= 1
        ll.remove(key)
      end
    end
  end

  def each(&prc)
    @store.each do |ll|
      ll.each do |node|
        prc.call(node.key, node.val)
      end
    end
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(count*2){LinkedList.new}
    @store.each do |ll|
      ll.each do |node|
        key = node.key
        val = node.val
        new_store[key.hash % (count*2)].append(key, val)
      end
    end 
    @store = new_store
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
  end
end
