module Logica
  module Predicates
    class Contradiction < Base
      def satisfied_by?(*arguments)
        false
      end

      def negated
        predicate_factory.tautology
      end

      def specialization_of?(other)
        true
      end

      def generalization_of_other?(other)
        false
      end

      def to_s
        'FALSE |n|'
      end
    end
  end
end
