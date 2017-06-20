module Logica
  module Predicates
    class Base
      include ComparableByState
      include OpenHouse::Acceptor

      ACCEPTOR_TYPE_ID = :predicate

      def self.predicate_factory
        Logica.predicate_factory
      end

      def unsatisfied_by?(*arguments)
        !satisfied_by?(*arguments)
      end

      def and(other)
        other.and_with_other(self)
      end

      def or(other)
        other.or_with_other(self)
      end

      def negated
        predicate_factory.negation(self)
      end

      def and_not(other)
        self.and(other.negated)
      end

      def or_not(other)
        self.or(other.negated)
      end

      def xor(other)
        self.or(other).and(self.and(other).negated)
      end

      def implies(other)
        negated.or(other)
      end

      def iff(other)
        # this is equivalent to xor(other).negated
        self.and(other).or(self.or(other).negated)
      end

      def specialization_of?(other)
        other.generalization_of_other?(self)
      end

      def generalization_of?(other)
        other.specialization_of?(self)
      end

      def generalization_of_other?(other)
        other == self
      end

      def generalization_of_negation_of?(other)
        false
      end

      def disjoint_with?(other)
        other.disjoint_with_other?(self)
      end

      def exhaustive_with?(other)
        other.exhaustive_with_other?(self)
      end

      def portion_satisfied_by(*arguments)
        satisfied_by?(*arguments) ? self : predicate_factory.tautology
      end

      def remainder_unsatisfied_by(*arguments)
        satisfied_by?(*arguments) ? predicate_factory.contradiction : self
      end

      def partially_applied_with(*first_arguments)
        return self if first_arguments.empty?
        validate_partial_application(first_arguments)
        do_partially_applied_with(first_arguments)
      end

      def to_method
        method(:satisfied_by?)
      end

      def arity
        to_method.arity
      end

      def to_proc
        to_method.to_proc
      end

      def to_s
        "#{name_and_attributes}#{to_s_suffix}"
      end

      def method_missing(name, *args, &block)
        if name.to_s.start_with?('and_with_')
          and_with_other(*args)
        elsif name.to_s.start_with?('or_with_')
          or_with_other(*args)
        elsif name.to_s.start_with?('generalization_of_')
          generalization_of_other?(*args)
        elsif name.to_s.start_with?('disjoint_with_')
          disjoint_with_other?(*args)
        elsif name.to_s.start_with?('exhaustive_with_')
          exhaustive_with_other?(*args)
        else
          ret = do_method_missing(name, *args, &block)
          ret == :__super__ ? super : ret
        end
      end

      def respond_to_missing?(method_name, include_private = false)
        prefixes = %w(and_with or_with generalization_of_ disjoint_with_ exhaustive_with_)

        prefixes.any? { |prefix| method_name.to_s.start_with?(prefix) } ||
          begin
            ret = do_respond_to_missing?(method_name, include_private)
            ret == :__super__ ? super : ret
          end
      end

      protected

      def and_with_conjunction(conjunction)
        conjunction.with_extra_predicate_last(self)
      end

      def and_with_at_least(at_least)
        at_least.and_with_other(self, other_first: false)
      end

      def and_with_other(other)
        predicate_factory.conjunction_from_pair(other, self)
      end

      def or_with_disjunction(disjunction)
        disjunction.with_extra_predicate_last(self)
      end

      def or_with_other(other)
        predicate_factory.disjunction_from_pair(other, self)
      end

      def generalization_of_conjunction?(conjunction)
        conjunction.specialization_of_other?(self)
      end

      def disjoint_with_other?(other)
        specialization_of?(other.negated)
      end

      def exhaustive_with_other?(other)
        negated.specialization_of?(other)
      end

      def without_predicates(preds, options = {})
        preds.include?(self) ? [] : [self]
      end

      def name_and_attributes
        "#{name}(#{attributes.values.join(', ')})"
      end

      def to_s_suffix
        " |#{arity}|"
      end

      private

      def validate_partial_application(first_arguments)
        if first_arguments.size > arity
          raise ArgumentError, partial_application_error_message(first_arguments)
        end
      end

      def partial_application_error_message(first_arguments)
        "cannot partially apply #{self} with #{first_arguments} (too many arguments)"
      end

      def do_partially_applied_with(first_arguments)
        predicate_factory.partial_application(self, first_arguments)
      end

      def name
        self.class.name.split('::').last
      end

      def predicate_factory
        self.class.predicate_factory
      end

      def do_method_missing(name, *args, &block)
        :__super__
      end

      def do_respond_to_missing?(method_name, include_private = false)
        :__super__
      end
    end
  end
end
