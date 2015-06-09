require "elliptic_curve/version"

# This is a simple implementation to play around with elliptic curves
# Most of it was taken from
# http://www.apprendre-en-ligne.net/crypto/menu/index.html

module EllipticCurve
  # The base class which holds an elliptic curve
  class EC
    attr_reader :a, :b, :p

    # y^2 = x^3 + ax + b
    # p: modulo
    def initialize(a, b, p)
      @a, @b, @p = a, b, p
    end

    # gets the inverse modulo p
    # Copied from http://en.wikipedia.org/wiki/Extended_Euclidean_algorithm#Modular_integers
    def get_inv_p(s)
      s < 0 and return get_inv_p(s % @p)
      t, newt = 0, 1
      r, newr = @p, s
      while newr != 0 do
        quotient = (r / newr).floor
        t, newt = newt, t - quotient * newt
        r, newr = newr, r - quotient * newr
      end
      if r > 1 then
        raise "#{s} is not invertible"
      end
      if t < 0 then
        return t + @p
      else
        return t
      end
    end

    # Adds two points together - searches the third point on a line between the two
    # points
    def add(p1, p2)
      if p2.is_infinity?
        return p1
      elsif p1.is_infinity?
        return p2
      elsif p1.x == p2.x
        if p1.y == -p2.y
          return P.new(ec, Float::INFINITY, Float::INFINITY)
        else
          k = (3 * p1.x**2+@a) * get_inv_p(2 * p1.y)
          x = (k**2 - 2 * p1.x) % @p
          return P.new(self, x, (k*(p1.x-x)-p1.y) % @p)
        end
      else
        k = (p2.y-p1.y) * get_inv_p(p2.x-p1.x)
        x = (k**2-p1.x-p2.x) % @p
        return P.new(self, x, (k * (p1.x-x)-p1.y) % @p)
      end
    end
  end

  # A point on an elliptic curve
  class P
    attr_reader :ec, :x, :y

    # ec: the elliptic curve
    # x, y: coordinates
    # if x == Float::INFINITY, y is ignored
    def initialize(ec, x, y)
      @ec, @x, @y = ec, x, y
    end

    # returns whether x is Float::INFINITY, ignores y
    def is_infinity?
      @x == Float::INFINITY
    end

    # Adds p2 to self
    def +(p2)
      @ec.add(self, p2)
    end

    # Multiplies itself by d
    def *(d)
      ([self] * d).inject(:+)
    end

    # Compare with another point
    def ==(o)
      @x == o.x && @y == o.y
    end
  end
end
