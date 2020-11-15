class CustomHash
  def initialize(hash)
    @hash = hash
  end

  def delete_if
    @hash.each { |i|
      if yield(i[0], i[1])
        @hash.delete(i[0])
      end
    }
    @hash
  end

  def empty?
    @hash.empty?
  end
end

hash = {"a" => 500, "b" => 3, "c" => 150, "d" => 1}
myhash = CustomHash.new(hash)
puts(myhash.delete_if {|key, value| value >= 10})
puts(myhash.empty?)
