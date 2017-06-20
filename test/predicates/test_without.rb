require 'minitest_helper'

class TestWithout < Logica::Test
  def test_conjunction_without0
    expected = divisibility_by_all([2, 3])
    [false, true].each do |recursive|
      actual = divisibility_by_all([2, 3]).without(divisibility_by(5), recursive: recursive)

      assert_equal expected, actual
    end
  end

  def test_conjunction_without1
    expected = divisibility_by_all([2, 3])
    [false, true].each do |recursive|
      actual = divisibility_by_all([2, 3, 5]).without(divisibility_by(5), recursive: recursive)

      assert_equal expected, actual
    end
  end

  def test_conjunction_without2
    expected = divisibility_by(2)
    [false, true].each do |recursive|
      actual = divisibility_by_all([2, 3]).without(divisibility_by(3), recursive: recursive)

      assert_equal expected, actual
    end
  end

  def test_conjunction_without3
    expected = divisibility_by_all([2, 3])
    [false, true].each do |recursive|
      actual = divisibility_by_all([2, 3, 5, 7]).without(divisibilities([5, 7]), recursive: recursive)

      assert_equal expected, actual
    end
  end

  def test_conjunction_without4
    expected = divisibility_by(2)
    [false, true].each do |recursive|
      actual = divisibility_by_all([2, 3, 5]).without(divisibilities([3, 5]), recursive: recursive)

      assert_equal expected, actual
    end
  end

  def test_conjunction_without5
    expected = tautology
    [false, true].each do |recursive|
      actual = divisibility_by_all([2, 3]).without(divisibilities([2, 3]), recursive: recursive)

      assert_equal expected, actual
    end
  end

  def test_conjunction_without6
    expected = tautology
    [false, true].each do |recursive|
      actual = divisibility_by_all([2, 3]).without(divisibilities([2, 3, 5]), recursive: recursive)

      assert_equal expected, actual
    end
  end

  def test_conjunction_without7
    expected = divisibility_by_all([2, 3])
    [false, true].each do |recursive|
      actual = example_conjunction.without(divisibility_by_any([5, 7, 11]), recursive: recursive)

      assert_equal expected, actual
    end
  end

  def test_conjunction_without8
    expected = example_conjunction
    actual = example_conjunction.without(divisibility_by(5))

    assert_equal expected, actual
  end

  def test_conjunction_without9
    expected = example_conjunction
    actual = example_conjunction.without(divisibilities([5, 7]))

    assert_equal expected, actual
  end

  def test_conjunction_without_recursive1
    expected = conjunction([divisibility_by(2), divisibility_by(3), divisibility_by_any([7, 11])])
    actual = example_conjunction.without(divisibility_by(5), recursive: true)

    assert_equal expected, actual
  end

  def test_conjunction_without_recursive2
    expected = divisibility_by_all([2, 3, 11])
    actual = example_conjunction.without(divisibilities([5, 7]), recursive: true)

    assert_equal expected, actual
  end

  # ---

  def test_disjunction_without0
    expected = divisibility_by_any([2, 3])
    [false, true].each do |recursive|
      actual = divisibility_by_any([2, 3]).without(divisibility_by(5), recursive: recursive)

      assert_equal expected, actual
    end
  end

  def test_disjunction_without1
    expected = divisibility_by_any([2, 3])
    [false, true].each do |recursive|
      actual = divisibility_by_any([2, 3, 5]).without(divisibility_by(5), recursive: recursive)

      assert_equal expected, actual
    end
  end

  def test_disjunction_without2
    expected = divisibility_by(2)
    [false, true].each do |recursive|
      actual = divisibility_by_any([2, 3]).without(divisibility_by(3), recursive: recursive)

      assert_equal expected, actual
    end
  end

  def test_disjunction_without3
    expected = divisibility_by_any([2, 3])
    [false, true].each do |recursive|
      actual = divisibility_by_any([2, 3, 5, 7]).without(divisibilities([5, 7]), recursive: recursive)

      assert_equal expected, actual
    end
  end

  def test_disjunction_without4
    expected = divisibility_by(2)
    [false, true].each do |recursive|
      actual = divisibility_by_any([2, 3, 5]).without(divisibilities([3, 5]), recursive: recursive)

      assert_equal expected, actual
    end
  end

  def test_disjunction_without5
    expected = contradiction
    [false, true].each do |recursive|
      actual = divisibility_by_any([2, 3]).without(divisibilities([2, 3]), recursive: recursive)

      assert_equal expected, actual
    end
  end

  def test_disjunction_without6
    expected = contradiction
    [false, true].each do |recursive|
      actual = divisibility_by_any([2, 3]).without(divisibilities([2, 3, 5]), recursive: recursive)

      assert_equal expected, actual
    end
  end

  def test_disjunction_without7
    expected = divisibility_by_any([2, 3])
    [false, true].each do |recursive|
      actual = example_disjunction.without(divisibility_by_all([5, 7, 11]), recursive: recursive)

      assert_equal expected, actual
    end
  end

  def test_disjunction_without8
    expected = example_disjunction
    actual = example_disjunction.without(divisibility_by(5))

    assert_equal expected, actual
  end

  def test_disjunction_without9
    expected = example_disjunction
    actual = example_disjunction.without(divisibilities([5, 7]))

    assert_equal expected, actual
  end

  def test_disjunction_without_recursive1
    expected = disjunction([divisibility_by(2), divisibility_by(3), divisibility_by_all([7, 11])])
    actual = example_disjunction.without(divisibility_by(5), recursive: true)

    assert_equal expected, actual
  end

  def test_disjunction_without_recursive2
    expected = divisibility_by_any([2, 3, 11])
    actual = example_disjunction.without(divisibilities([5, 7]), recursive: true)

    assert_equal expected, actual
  end

  # ---

  def test_at_least_without
    expected = at_least(2, divisibilities([2, 3, 5]))
    actual = at_least(2, divisibilities([2, 3, 5, 7])).without(divisibility_by(7))

    assert_equal expected, actual
  end

  def test_at_least_without_recursive
    expected = at_least(2, divisibilities([2, 3, 5, 11]))
    actual = at_least(2, divisibilities([2, 3, 5]) + [divisibility_by_all([7, 11])]).without(divisibility_by(7), recursive: true)

    assert_equal expected, actual
  end
end
