require 'minitest_helper'

class TestDisjunction < Logica::Test
  def test_null
    assert_equal(null_disjunction, contradiction)
  end

  def test_unitary
    assert_equal(unitary_disjunction, unrelated_predicates.first)
  end

  def test_construction
    assert_equal(unrelated_predicates, full_disjunction.predicates)
  end

  def test_wrong_construction
    assert_raises(ArgumentError) do
      full_disjunction.or(have_same_prefix_of_length_one)
    end
  end

  def test_or_with_other
    expected = second_disjunction
    actual = unrelated_predicates[2].or_with_other(unrelated_predicates[1])

    assert_equal expected, actual
  end

  def test_or_with_disjunction
    expected = disjunction(unrelated_predicates + more_unrelated_predicates)
    actual = full_disjunction.or(other_disjunction)

    assert_equal expected, actual
  end

  def test_associativity
    disjunction_of_disjunctions1 = first_disjunction.or(unrelated_predicates[2])
    disjunction_of_disjunctions2 = unrelated_predicates[0].or(second_disjunction)

    assert_equal(full_disjunction, disjunction_of_disjunctions1)
    assert_equal(full_disjunction, disjunction_of_disjunctions2)
  end

  def test_neutrality
    assert_equal(first_disjunction, first_disjunction.or(contradiction))
    assert_equal(first_disjunction, contradiction.or(first_disjunction))
  end

  def test_absorption
    assert_equal(tautology, first_disjunction.or(tautology))
    assert_equal(tautology, tautology.or(first_disjunction))
  end

  def test_idempotence1
    assert_equal(unrelated_predicates.first, unrelated_predicates.first.or(unrelated_predicates.first))
  end

  def test_idempotence2
    assert_equal(tautology, tautology.or(tautology))
  end

  def test_idempotence3
    assert_equal(contradiction, contradiction.or(contradiction))
  end

  def test_idempotence4
    assert_equal(example_disjunction, example_disjunction.or(example_disjunction))
  end

  def test_idempotence5
    assert_equal(example_conjunction, example_conjunction.and(example_conjunction))
  end

  def test_subsumption
    assert_equal(first_disjunction, first_disjunction.or(unrelated_predicates.first))
    assert_equal(first_disjunction, unrelated_predicates.first.or(first_disjunction))
  end

  def test_annihilation1
    assert_equal(tautology, first_disjunction.or(unrelated_predicates.first.negated))
    assert_equal(tautology, unrelated_predicates.first.negated.or(first_disjunction))
  end

  def test_annihilation2
    assert_equal(tautology, tautology.or(contradiction))
    assert_equal(tautology, contradiction.or(tautology))
  end

  def test_annihilation3
    assert_equal(tautology, annihilating_disjunction.or(full_disjunction))
  end

  def test_annihilation4
    assert_equal(tautology, example_disjunction.or_not(example_disjunction))
  end

  def test_annihilation5
    assert_equal(tautology, example_conjunction.or_not(example_conjunction))
  end

  def test_specialization_of_itself
    assert(full_disjunction.specialization_of?(full_disjunction))
  end

  def test_arity
    assert_equal(1, full_disjunction.arity)
  end

  def test_to_s
    assert_equal('OR(IsDivisibleBy(2), IsDivisibleBy(3)) |1|', first_disjunction.to_s)

    other_disjunction = unrelated_predicates[0].or_not(unrelated_predicates[1])

    assert_equal('OR(IsDivisibleBy(2), NOT(IsDivisibleBy(3))) |1|', other_disjunction.to_s)

    complex_conjunction = other_disjunction.and(unrelated_predicates[2])

    assert_equal('AND(OR(IsDivisibleBy(2), NOT(IsDivisibleBy(3))), IsDivisibleBy(5)) |1|', complex_conjunction.to_s)
  end

  private

  def null_disjunction
    disjunction([])
  end

  def unitary_disjunction
    disjunction([unrelated_predicates.first])
  end

  def first_disjunction
    disjunction(unrelated_predicates[0..1])
  end

  def second_disjunction
    disjunction(unrelated_predicates[1..2])
  end

  def full_disjunction
    disjunction(unrelated_predicates[0..2])
  end

  def other_disjunction
    disjunction(more_unrelated_predicates)
  end

  def annihilating_disjunction
    more_unrelated_predicates[0].or_not(unrelated_predicates[1])
  end
end
