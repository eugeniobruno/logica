require 'minitest_helper'

class TestPartialApplication < Logica::Test
  def test_with_zero_arguments
    partial_application = have_same_prefix_of_length_one.partially_applied_with

    assert_equal(2, partial_application.arity)

    assert(!partial_application.satisfied_by?('Can', 'you'))
  end

  def test_with_one_argument
    partial_application = have_same_prefix_of_length_one.partially_applied_with('hear')

    assert_equal(1, partial_application.arity)

    assert(!partial_application.satisfied_by?('me?'))
  end

  def test_with_all_arguments
    partial_application = have_same_prefix_of_length_one.partially_applied_with('Hell', 'yes')

    assert_equal(0, partial_application.arity)

    assert(!partial_application.satisfied_by?)
  end

  def test_with_extra_arguments
    assert_raises(ArgumentError) do
      have_same_prefix_of_length_one.partially_applied_with('Ten', 'O', 'clock')
    end
  end

  def test_partial_application
    partial_application1 = have_same_prefix_of_length_one.partially_applied_with('An')
    partial_application2 = partial_application1.partially_applied_with('arrow')

    assert(!partial_application2.satisfied_by?)
  end

  def test_to_s
    partial_application1 = have_same_prefix_of_length_one.partially_applied_with('Three')
    partial_application2 = have_same_prefix_of_length_one.partially_applied_with('O', 'clock')

    assert_equal('HaveSamePrefixOfLength(1)(Three) |1|',    partial_application1.to_s)
    assert_equal('HaveSamePrefixOfLength(1)(O, clock) |0|', partial_application2.to_s)
  end
end
