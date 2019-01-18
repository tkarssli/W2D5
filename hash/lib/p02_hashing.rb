class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    hash_counter = 0
    self.each_with_index do |el, i|
      hash_counter = hash_counter ^ (el * i).hash
    end
    hash_counter
  end
end

class String
  def hash
    hash_counter = 0
    self.chars.each_with_index do |el ,i|
      hash_counter = hash_counter ^ (el.ord * i).hash
    end
    hash_counter
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    hash_counter = 0
    self.each do |key, value|
      hash_counter = hash_counter ^ key.hash ^ value.hash
    end
    hash_counter
  end
end
