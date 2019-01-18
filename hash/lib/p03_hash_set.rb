require_relative "p02_hashing"

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    unless include?(key)
      @count += 1
      self[key] << key
      resize! if count == num_buckets
    end
  end

  def remove(key)
    @count -= 1 if self[key].delete(key)
  end

  def include?(key)
    self[key].include?(key)
  end
  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num.hash % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(count*2){Array.new}
    @store.each do |bucket|
      bucket.each do |el|
        new_store[el.hash % (count*2)] << el
      end
    end 
    @store = new_store
  end
end
