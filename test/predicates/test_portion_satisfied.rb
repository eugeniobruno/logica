require 'minitest_helper'

class TestPortionSatisfied < Logica::Test
  def test_conjunction_full_portion1
    expected = example_conjunction
    actual = example_conjunction.portion_satisfied_by(30)

    assert_equal expected, actual
  end

  def test_conjunction_full_portion2
    expected = example_conjunction
    actual = example_conjunction.portion_satisfied_by(2310) # 2*3*5*7*11

    assert_equal expected, actual
  end

  def test_conjunction_complex_portion1
    expected = conjunction([divisibility_by(3), divisibility_by_any([5, 7, 11])])
    actual = example_conjunction.portion_satisfied_by(15)

    assert_equal expected, actual
  end

  def test_conjunction_complex_portion2
    expected = conjunction([divisibility_by(3), divisibility_by_any([5, 7, 11])])
    actual = example_conjunction.portion_satisfied_by(1155) # 3*5*7*11

    assert_equal expected, actual
  end

  def test_conjunction_complex_portion3
    expected = conjunction([divisibility_by(2), divisibility_by_any([5, 7, 11])])
    actual = example_conjunction.portion_satisfied_by(10)

    assert_equal expected, actual
  end

  def test_conjunction_disjunctive_portion1
    expected = divisibility_by_any([5, 7, 11])
    actual = example_conjunction.portion_satisfied_by(5)

    assert_equal expected, actual
  end

  def test_conjunction_disjunctive_portion2
    expected = divisibility_by_any([5, 7, 11])
    actual = example_conjunction.portion_satisfied_by(385) # 5*7*11

    assert_equal expected, actual
  end

  def test_conjunction_conjunctive_portion
    expected = divisibility_by_all([2, 3])
    actual = example_conjunction.portion_satisfied_by(6)

    assert_equal expected, actual
  end

  def test_conjunction_empty_portion
    expected = tautology
    actual = example_conjunction.portion_satisfied_by(13)

    assert_equal expected, actual
  end

  # ---

  def test_disjunction_full_portion1
    expected = example_disjunction
    actual = example_disjunction.portion_satisfied_by(2)

    assert_equal expected, actual
  end

  def test_disjunction_full_portion2
    expected = example_disjunction
    actual = example_disjunction.portion_satisfied_by(385)

    assert_equal expected, actual
  end

  def test_disjunction_full_portion3
    expected = example_disjunction
    actual = example_disjunction.portion_satisfied_by(2310)

    assert_equal expected, actual
  end

  def test_disjunction_complex_portion1
    expected = divisibility_by_all([7, 11])
    actual = example_disjunction.portion_satisfied_by(77)

    assert_equal expected, actual
  end

  def test_disjunction_complex_portion2
    expected = divisibility_by(5)
    actual = example_disjunction.portion_satisfied_by(5)

    assert_equal expected, actual
  end

  def test_disjunction_empty_portion
    expected = tautology
    actual = example_disjunction.portion_satisfied_by(13)

    assert_equal expected, actual
  end

  # ---

  def test_at_least1
    expected = at_least_two
    actual = at_least_two.portion_satisfied_by(10)

    assert_equal expected, actual
  end

  def test_at_least2
    expected = divisibility_by(2)
    actual = at_least_two.portion_satisfied_by(8)

    assert_equal expected, actual
  end
end
