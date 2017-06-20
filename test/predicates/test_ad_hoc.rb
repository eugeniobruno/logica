require 'minitest_helper'

class TestAdHoc < Logica::Test
  def test_satisfied_by
    assert(!greater_than_five.satisfied_by?(4))
    assert(!greater_than_five.satisfied_by?(5))

    assert(greater_than_five.satisfied_by?(6))
    assert(greater_than_five.satisfied_by?(7))

    assert_equal(1, greater_than_five.arity)
  end

  def test_missing_block
    assert_raises(ArgumentError) do
      ad_hoc
    end
  end

  def test_to_s
    assert_equal('MoreThan5() |1|', greater_than_five.to_s)
  end

  private

  def greater_than_five
    ad_hoc('MoreThan5') do |number|
      number > 5
    end
  end
end
