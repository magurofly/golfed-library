class SegmentTree
  # @param n size | array
  # @param id identity
  # @param op binary operation (monoid)
  def initialize(n, id, &op)
    @m = n.is_a? Array ? n.size : n
    @n = 1 << (@l = (@m - 1).bit_length)
    @a = [id] * (@n + @m)
    @op = op

    # initialize by array (optional)
    if n.is_a? Array
      @a[@n, m] = a
      (size-1).downto(1) { |i| update i }
    end
  end

  # required!
  def update(i)
    @a[i] = @op[@a[2*i], @a[2*i+1]]
  end

  # @param i index | range (half-open)
  def [](i)
    if i.is_a? Range
      l, r = i.begin + @n, i.end + @n
      x = y = @a[0]
      while l < r
        x = @op[x, @a[(l += 1) - 1]] if l.odd?
        y = @op[@a[r -= 1], y] if r.odd?
        l >>= 1
        r >>= 1
      end
      @op[x, y]
    else
      @a[i + @n]
    end
  end

  # @param i index
  # @param x value
  def []=(i, x)
    @a[i += @n] = x
    (1..@l).each { |j| update i >> j }
  end

  #TODO: implement binary search
end
