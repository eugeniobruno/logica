require 'minitest_helper'

class TestConjunction < Logica::Test
  def test_null
    assert_equal(null_conjunction, tautology)
  end

  def test_unitary
    assert_equal(unitary_conjunction, unrelated_predicates.first)
  end

  def test_construction
    assert_equal(unrelated_predicates, full_conjunction.predicates)
  end

  def test_wrong_construction
    assert_raises(ArgumentError) do
      full_conjunction.and(have_same_prefix_of_length_one)
    end
  end

  def test_and_with_other
    expected = second_conjunction
    actual = unrelated_predicates[2].and_with_other(unrelated_predicates[1])

    assert_equal expected, actual
  end

  def test_and_with_conjunction
    expected = conjunction(unrelated_predicates + more_unrelated_predicates)
    actual = full_conjunction.and(other_conjunction)

    assert_equal expected, actual
  end

  def test_associativity
    conjunction_of_conjunctions1 = first_conjunction.and(unrelated_predicates[2])
    conjunction_of_conjunctions2 = unrelated_predicates[0].and(second_conjunction)

    assert_equal(full_conjunction, conjunction_of_conjunctions1)
    assert_equal(full_conjunction, conjunction_of_conjunctions2)
  end

  def test_neutrality
    assert_equal(first_conjunction, first_conjunction.and(tautology))
    assert_equal(first_conjunction, tautology.and(first_conjunction))
  end

  def test_absorption
    assert_equal(contradiction, first_conjunction.and(contradiction))
    assert_equal(contradiction, contradiction.and(first_conjunction))
  end

  def test_idempotence1
    assert_equal(unrelated_predicates.first, unrelated_predicates.first.and(unrelated_predicates.first))
  end

  def test_idempotence2
    assert_equal(tautology, tautology.and(tautology))
  end

  def test_idempotence3
    assert_equal(contradiction, contradiction.and(contradiction))
  end

  def test_idempotence4
    assert_equal(example_conjunction, example_conjunction.and(example_conjunction))
  end

  def test_idempotence5
    assert_equal(example_disjunction, example_disjunction.and(example_disjunction))
  end

  def test_subsumption
    assert_equal(first_conjunction, first_conjunction.and(unrelated_predicates.first))
    assert_equal(first_conjunction, unrelated_predicates.first.and(first_conjunction))
  end

  def test_annihilation1
    assert_equal(contradiction, first_conjunction.and(is_even.negated))
    assert_equal(contradiction, is_even.negated.and(first_conjunction))
  end

  def test_annihilation2
    assert_equal(contradiction, tautology.and(contradiction))
    assert_equal(contradiction, contradiction.and(tautology))
  end

  def test_annihilation3
    assert_equal(contradiction, annihilating_conjunction.and(full_conjunction))
  end

  def test_annihilation4
    assert_equal(contradiction, example_conjunction.and_not(example_conjunction))
  end

  def test_annihilation5
    assert_equal(contradiction, example_disjunction.and_not(example_disjunction))
  end

  def test_specialization_of_itself
    assert(full_conjunction.specialization_of?(full_conjunction))
  end

  def test_arity
    assert_equal(1, full_conjunction.arity)
  end

  def test_to_s
    assert_equal('AND(IsDivisibleBy(2), IsDivisibleBy(3)) |1|', first_conjunction.to_s)

    other_conjunction = unrelated_predicates[0].and_not(unrelated_predicates[1])

    assert_equal('AND(IsDivisibleBy(2), NOT(IsDivisibleBy(3))) |1|', other_conjunction.to_s)

    complex_disjunction = other_conjunction.or(unrelated_predicates[2])

    assert_equal('OR(AND(IsDivisibleBy(2), NOT(IsDivisibleBy(3))), IsDivisibleBy(5)) |1|', complex_disjunction.to_s)
  end

  private

  def null_conjunction
    conjunction([])
  end

  def unitary_conjunction
    conjunction([unrelated_predicates.first])
  end

  def first_conjunction
    conjunction(unrelated_predicates[0..1])
  end

  def second_conjunction
    conjunction(unrelated_predicates[1..2])
  end

  def full_conjunction
    conjunction(unrelated_predicates[0..2])
  end

  def other_conjunction
    conjunction(more_unrelated_predicates)
  end

  def annihilating_conjunction
    more_unrelated_predicates[0].and_not(unrelated_predicates[1])
  end
end
