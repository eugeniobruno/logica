require 'minitest_helper'

class TestGeneralizations < Logica::Test
  def test_examples
    assert(contradiction.specialization_of?(divisibility_by(2)))
    assert(!tautology.specialization_of?(divisibility_by(2)))

    assert(!divisibility_by(3).specialization_of?(divisibility_by(2)))
    assert( divisibility_by(4).specialization_of?(divisibility_by(2)))
    assert(!divisibility_by(5).specialization_of?(divisibility_by(2)))
    assert( divisibility_by(6).specialization_of?(divisibility_by(2)))
    assert( divisibility_by(12).specialization_of?(divisibility_by(2)))

    assert( divisibility_by(2).generalization_of?(contradiction))
    assert(!divisibility_by(2).generalization_of?(tautology))

    assert(!divisibility_by(2).generalization_of?(divisibility_by(3)))
    assert( divisibility_by(2).generalization_of?(divisibility_by(4)))
    assert(!divisibility_by(2).generalization_of?(divisibility_by(5)))
    assert( divisibility_by(2).generalization_of?(divisibility_by(6)))
    assert( divisibility_by(2).generalization_of?(divisibility_by(12)))
  end

  def test_related_pairs
    expected = divisibility_by(4)
    actual1  = divisibility_by(2).and(divisibility_by(4))
    actual2  = divisibility_by(4).and(divisibility_by(2))

    assert_equal expected, actual1
    assert_equal expected, actual2
  end

  def test_conjunction_simplification
    expected = divisibility_by(5).and(divisibility_by(12))
    actual   = full_conjunction

    assert_equal expected, actual
  end

  def test_conjunction_degeneration
    expected = contradiction
    actual   = divisibility_by(4).and_not(divisibility_by(2))

    assert_equal expected, actual
  end

  def test_disjunction_simplification
    expected = divisibility_by(2).or(divisibility_by(3)).or(divisibility_by(5))
    actual   = full_disjunction

    assert_equal expected, actual
  end

  def test_disjunction_degeneration
    expected = tautology
    actual   = divisibility_by(2).or_not(divisibility_by(4))

    assert_equal expected, actual
  end

  def test_conjunction
    assert(divisibility_by(2).generalization_of?(full_conjunction))
    assert(full_conjunction.specialization_of?(divisibility_by(2)))

    assert(divisibility_by(4).generalization_of?(full_conjunction))
    assert(full_conjunction.specialization_of?(divisibility_by(4)))
    # Note that 4 is not in DIVISORS

    assert(divisibility_by(5).generalization_of?(full_conjunction))
    assert(full_conjunction.specialization_of?(divisibility_by(5)))
  end

  def test_disjunction
    assert(divisibility_by(2).specialization_of?(full_disjunction))
    assert(full_disjunction.generalization_of?(divisibility_by(2)))

    assert(divisibility_by(5).specialization_of?(full_disjunction))
    assert(full_disjunction.generalization_of?(divisibility_by(5)))

    assert(divisibility_by(15).specialization_of?(full_disjunction))
    assert(full_disjunction.generalization_of?(divisibility_by(15)))
    # Note that 15 is not in DIVISORS
  end

  def test_negation
    assert(divisibility_by(2).negated.specialization_of?(divisibility_by(4).negated))
    assert(divisibility_by(4).negated.generalization_of?(divisibility_by(2).negated))
  end

  def test_conjunction_with_negation
    assert(divisibility_by(2).and_not(divisibility_by(5)).specialization_of?(divisibility_by(2)))
    assert(divisibility_by(2).generalization_of?(divisibility_by(2).and_not(divisibility_by(5))))
  end

  def test_disjunction_with_negation
    assert(divisibility_by(2).or_not(divisibility_by(5)).generalization_of?(divisibility_by(2)))
    assert(divisibility_by(2).specialization_of?(divisibility_by(2).or_not(divisibility_by(5))))
  end

  def test_tautology
    assert(tautology.generalization_of?(divisibility_by(2)))
    assert(divisibility_by(2).specialization_of?(tautology))
  end

  def test_contradiction
    assert(contradiction.specialization_of?(divisibility_by(2)))
    assert(divisibility_by(2).generalization_of?(contradiction))
  end

  private

  DIVISORS = [2, 3, 5, 6, 12].freeze

  def full_conjunction
    @full_conjunction ||= divisibility_by_all(divisors)
  end

  def full_disjunction
    @full_disjunction ||= divisibility_by_any(divisors)
  end

  def divisors
    DIVISORS
  end
end
