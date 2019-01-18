class MaxIntSet
  def initialize(max)
    @max = max
    @store = Array.new(max)
  end

  def insert(num)
    v_num = validate!(num)
    @store[v_num] = true
  end

  def remove(num)
    v_num = validate!(num)
    @store[v_num] = false
  end

  def include?(num)
    @store[validate!(num)]
  end

  private

  def is_valid?(num)
    raise "Out of bounds" if num > @max || num < 0    
    true
  end

  def validate!(num)
    is_valid?(Integer(num))
    Integer(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    unless include?(num)
      @count += 1
      self[num] << num
      resize! if count == num_buckets
    end
  end

  def remove(num)
    @count -= 1 if self[num].delete(num)
    
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(count*2){Array.new}
    @store.each do |bucket|
      bucket.each do |el|
        new_store[el % (count*2)] << el
      end
    end 
    @store = new_store
  end
end
