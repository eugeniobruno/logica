require 'coverage_helper'
require 'minitest/autorun'
require 'minitest/bender'
require 'pry-byebug'
require 'logica'

require 'predicates/examples/is_greater_than'
require 'predicates/examples/is_less_than'
require 'predicates/examples/has_value_in_key'
require 'predicates/examples/is_divisible_by'
require 'predicates/examples/have_same_prefix_of_length'

module Logica
  class Test < Minitest::Test
    def predicate_factory
      Logica.predicate_factory
    end

    def method_missing(name, *args, &block)
      if predicate_factory.respond_to?(name)
        predicate_factory.public_send(name, *args, &block)
      else
        super
      end
    end

    def respond_to_missing?(method_name, include_private = false)
      predicate_factory.respond_to?(method_name) || super
    end

    private

    def divisibility_by(divisor)
      IsDivisibleBy.new(divisor)
    end

    def divisibility_by_all(numbers)
      conjunction(divisibilities(numbers))
    end

    def divisibility_by_any(numbers)
      disjunction(divisibilities(numbers))
    end

    def divisibilities(numbers)
      numbers.map { |n| divisibility_by(n) }
    end

    def is_even
      divisibility_by(2)
    end

    def is_odd
      is_even.negated
    end

    def is_greater_than(threshold)
      IsGreaterThan.new(threshold)
    end

    def is_less_than(threshold)
      IsLessThan.new(threshold)
    end

    def unrelated_predicates
      divisibilities([2, 3, 5])
    end

    def more_unrelated_predicates
      divisibilities([7, 11, 13])
    end

    def example_disjunction
      third = divisibility_by_all([5, 7, 11])
      disjunction([divisibility_by(2), divisibility_by(3), third])
    end

    def example_conjunction
      third = divisibility_by_any([5, 7, 11])
      conjunction([divisibility_by(2), divisibility_by(3), third])
    end

    def at_least_two
      at_least(2, unrelated_predicates)
    end

    def at_most_two
      at_most(2, unrelated_predicates)
    end

    def exactly_two
      exactly(2, unrelated_predicates)
    end

    def hash1
      { tone: :light, color: :yellow, received: false }
    end

    def hash2
      { tone: :light, color: :red, received: true }
    end

    def hash3
      { tone: :dark,  color: :yellow, received: false }
    end

    def hash4
      { tone: :dark,  color: :red, received: true }
    end

    def have_same_prefix_of_length_one
      HaveSamePrefixOfLength.new(1)
    end
  end
end
