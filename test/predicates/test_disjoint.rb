require 'minitest_helper'

class TestDisjoint < Logica::Test
  def setup
    @is_red   = HasValueInKey.new(:color, :red)
    @is_green = HasValueInKey.new(:color, :green)
    @is_blue  = HasValueInKey.new(:color, :blue)

    @is_dark  = HasValueInKey.new(:tone, :dark)

    @color_predicates = [is_red, is_green, is_blue]
  end

  def test_irreflexivity
    color_predicates.each do |predicate|
      assert(!predicate.disjoint_with?(predicate))
    end

    assert(!is_dark.disjoint_with?(is_dark))
  end

  def test_symmetry
    color_predicates.combination(2).each do |p1, p2|
      assert(p1.disjoint_with?(p2))
      assert(p2.disjoint_with?(p1))
    end
  end

  def test_default
    color_predicates.each do |predicate|
      assert(!predicate.disjoint_with?(is_dark))
    end

    assert(!is_dark.disjoint_with?(ad_hoc { |s| s.whatever? }))
  end

  def test_normal_conjunction
    conjunction1 = is_red.and(is_dark)
    conjunction2 = is_dark.and(is_red)

    assert(!conjunction1.satisfied_by?(hash1))
    assert(!conjunction1.satisfied_by?(hash2))
    assert(!conjunction1.satisfied_by?(hash3))
    assert( conjunction1.satisfied_by?(hash4))

    assert(!conjunction2.satisfied_by?(hash1))
    assert(!conjunction2.satisfied_by?(hash2))
    assert(!conjunction2.satisfied_by?(hash3))
    assert( conjunction2.satisfied_by?(hash4))
  end

  def test_normal_disjunction
    disjunction1 = is_red.or(is_dark)
    disjunction2 = is_dark.or(is_red)

    assert(!disjunction1.satisfied_by?(hash1))
    assert( disjunction1.satisfied_by?(hash2))
    assert( disjunction1.satisfied_by?(hash3))
    assert( disjunction1.satisfied_by?(hash4))

    assert(!disjunction2.satisfied_by?(hash1))
    assert( disjunction2.satisfied_by?(hash2))
    assert( disjunction2.satisfied_by?(hash3))
    assert( disjunction2.satisfied_by?(hash4))
  end

  def test_degenerated_conjunction_1
    assert_equal contradiction, conjunction(color_predicates)
  end

  def test_degenerated_conjunction_2
    color_predicates.combination(2) do |p1, p2|
      assert_equal contradiction, p1.and(p2)
      assert_equal contradiction, p2.and(p1)
      # because p1 and p2 are disjoint
    end
  end

  def test_degenerated_conjunction3
    normal_conjunction = is_green.and(is_dark)
    assert_equal contradiction, is_red.and(normal_conjunction)
    assert_equal contradiction, normal_conjunction.and(is_red)
  end

  private

  attr_reader :is_red, :is_green, :is_blue, :is_dark, :color_predicates
end
