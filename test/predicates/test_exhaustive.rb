require 'minitest_helper'

class TestExhaustive < Logica::Test
  def setup
    @is_received     = HasValueInKey.new(:received, true)
    @is_not_received = HasValueInKey.new(:received, false)

    @is_red = HasValueInKey.new(:color, :red)
  end

  def test_irreflexivity
    assert(!is_received.exhaustive_with?(is_received))
    assert(!is_not_received.exhaustive_with?(is_not_received))
  end

  def test_irreflexivity_exception
    assert(tautology.exhaustive_with?(tautology))
  end

  def test_symmetry
    assert(is_received.exhaustive_with?(is_not_received))
    assert(is_not_received.exhaustive_with?(is_received))
  end

  def test_default
    assert(!is_received.exhaustive_with?(is_red))
    assert(!is_red.exhaustive_with?(is_received))
  end

  def test_normal_conjunction
    conjunction1 = is_red.and(is_received)
    conjunction2 = is_received.and(is_red)

    assert(!conjunction1.satisfied_by?(hash1))
    assert(conjunction1.satisfied_by?(hash2))
    assert(!conjunction1.satisfied_by?(hash3))
    assert( conjunction1.satisfied_by?(hash4))

    assert(!conjunction2.satisfied_by?(hash1))
    assert(conjunction2.satisfied_by?(hash2))
    assert(!conjunction2.satisfied_by?(hash3))
    assert( conjunction2.satisfied_by?(hash4))
  end

  def test_normal_disjunction
    disjunction1 = is_red.or(is_received)
    disjunction2 = is_received.or(is_red)

    assert(!disjunction1.satisfied_by?(hash1))
    assert( disjunction1.satisfied_by?(hash2))
    assert(!disjunction1.satisfied_by?(hash3))
    assert( disjunction1.satisfied_by?(hash4))

    assert(!disjunction2.satisfied_by?(hash1))
    assert( disjunction2.satisfied_by?(hash2))
    assert(!disjunction2.satisfied_by?(hash3))
    assert( disjunction2.satisfied_by?(hash4))
  end

  def test_degenerated_disjunction
    assert_equal(tautology, is_received.or(is_not_received))
    # not because they are opposites, but because they are exhaustive with each other
    assert_equal(tautology, is_not_received.or(is_received))
  end

  private

  attr_reader :is_red, :is_received, :is_not_received
end
