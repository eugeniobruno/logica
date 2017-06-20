module Logica
  module Predicates
    class Negation < Base
      attr_reader :predicate

      def initialize(predicate)
        @predicate = predicate
      end

      def satisfied_by?(*arguments)
        predicate.unsatisfied_by?(*arguments)
      end

      def negated
        predicate
      end

      def specialization_of?(other)
        other.generalization_of_negation_of?(predicate)
      end

      def generalization_of_negation_of?(other)
        predicate.specialization_of?(other)
      end

      def disjoint_with_other?(other)
        predicate.generalization_of?(other)
      end

      def arity
        predicate.arity
      end

      def name_and_attributes
        "#{name}(#{predicate.name_and_attributes})"
      end

      private

      def name
        'NOT'
      end
    end
  end
end
