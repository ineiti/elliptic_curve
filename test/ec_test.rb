require 'test/unit'
$:.unshift File.expand_path('../../lib', __FILE__)
require 'elliptic_curve'

class ECTest < Test::Unit::TestCase
  include EllipticCurve

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    # Do nothing
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.

  def teardown
    # Do nothing
  end

  def test_ec
    ec = EC.new(1, 2, 11)
    assert_equal(10, ec.get_inv_p(10))
    assert_equal(10, ec.get_inv_p(-1))
  end

  # Tested according to http://www.apprendre-en-ligne.net/crypto/menu/index.html
  def test_p
    ec = EC.new(1, 2, 11)
    p1 = P.new(ec, 4, 2)
    p2 = p1 + p1
    assert_equal(8, p2.x)
    assert_equal(4, p2.y)
    p3 = p2 + p1
    assert_equal(2, p3.x)
    assert_equal(10, p3.y)

    assert_equal(p3, p1 * 3)
  end

  # Test infinity-cases
  def test_infinity
    ec = EC.new(1, 2, 11)
    p_inf = P.new(ec, Float::INFINITY, Float::INFINITY)
    p_normal = P.new(ec, 4, 2)
    assert_equal p_normal, p_inf + p_normal
    assert_equal p_normal, p_normal + p_inf
    assert_equal p_inf, p_inf + p_inf
  end
end