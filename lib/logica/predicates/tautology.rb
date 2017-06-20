module Logica
  module Predicates
    class Tautology < Base
      def satisfied_by?(*arguments)
        true
      end

      def negated
        predicate_factory.contradiction
      end

      def specialization_of?(other)
        other.generalization_of_tautology?(self)
      end

      def generalization_of_other?(other)
        true
      end

      def generalization_of_negation_of?(other)
        true
      end

      def to_s
        'TRUE |n|'
      end
    end
  end
end
