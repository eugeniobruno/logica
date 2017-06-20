require 'minitest_helper'

class TestRemainderUnsatisfied < Logica::Test
  def test_conjunction_empty_remainder1
    expected = contradiction
    actual = example_conjunction.remainder_unsatisfied_by(30)

    assert_equal expected, actual
  end

  def test_conjunction_empty_remainder2
    expected = contradiction
    actual = example_conjunction.remainder_unsatisfied_by(2310) # 2*3*5*7*11

    assert_equal expected, actual
  end

  def test_conjunction_literal_remainder1
    expected = divisibility_by(2)
    actual = example_conjunction.remainder_unsatisfied_by(15)

    assert_equal expected, actual
  end

  def test_conjunction_literal_remainder2
    expected = divisibility_by(2)
    actual = example_conjunction.remainder_unsatisfied_by(1155) # 3*5*7*11

    assert_equal expected, actual
  end

  def test_conjunction_literal_remainder3
    expected = divisibility_by(3)
    actual = example_conjunction.remainder_unsatisfied_by(10)

    assert_equal expected, actual
  end

  def test_conjunction_conjunctive_remainder1
    expected = divisibility_by_all([2, 3])
    actual = example_conjunction.remainder_unsatisfied_by(5)

    assert_equal expected, actual
  end

  def test_conjunction_conjunctive_remainder2
    expected = divisibility_by_all([2, 3])
    actual = example_conjunction.remainder_unsatisfied_by(385) # 5*7*11

    assert_equal expected, actual
  end

  def test_conjunction_disjunctive_remainder
    expected = divisibility_by_any([5, 7, 11])
    actual = example_conjunction.remainder_unsatisfied_by(6)

    assert_equal expected, actual
  end

  def test_conjunction_full_remainder
    expected = example_conjunction
    actual = example_conjunction.remainder_unsatisfied_by(13)

    assert_equal expected, actual
  end

  # ---

  def test_disjunction_empty_remainder1
    expected = contradiction
    actual = example_disjunction.remainder_unsatisfied_by(2)

    assert_equal expected, actual
  end

  def test_disjunction_empty_remainder2
    expected = contradiction
    actual = example_disjunction.remainder_unsatisfied_by(385)

    assert_equal expected, actual
  end

  def test_disjunction_empty_remainder3
    expected = contradiction
    actual = example_disjunction.remainder_unsatisfied_by(2310)

    assert_equal expected, actual
  end

  def test_disjunction_complex_remainder1
    expected = divisibility_by_any([2, 3, 5])
    actual = example_disjunction.remainder_unsatisfied_by(77)

    assert_equal expected, actual
  end

  def test_disjunction_complex_remainder2
    expected = disjunction([divisibility_by(2), divisibility_by(3), divisibility_by_all([7, 11])])
    actual = example_disjunction.remainder_unsatisfied_by(5)

    assert_equal expected, actual
  end

  def test_disjunction_full_remainder
    expected = example_disjunction
    actual = example_disjunction.remainder_unsatisfied_by(13)

    assert_equal expected, actual
  end

  # ---

  def test_at_least1
    expected = contradiction
    actual = at_least_two.remainder_unsatisfied_by(10)

    assert_equal expected, actual
  end

  def test_at_least2
    expected = divisibility_by(3).or(divisibility_by(5))
    actual = at_least_two.remainder_unsatisfied_by(8)

    assert_equal expected, actual
  end
end
