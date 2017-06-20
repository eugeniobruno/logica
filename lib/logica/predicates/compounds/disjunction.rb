module Logica
  module Predicates
    module Compounds
      class Disjunction < Base
        class << self
          def internal_binary_operation
            :or
          end

          def neutral_element
            predicate_factory.contradiction
          end

          def absorbing_element
            predicate_factory.tautology
          end
        end

        def satisfied_by?(*arguments)
          predicates.any? { |predicate| predicate.satisfied_by?(*arguments) }
        end

        def or(other)
          other.or_with_disjunction(self)
        end

        def or_with_other(other)
          with_extra_predicate_first(other)
        end

        def specialization_of?(other)
          other.generalization_of_disjunction?(self)
        end

        def generalization_of_other?(other)
          predicates.any? { |predicate| predicate.generalization_of?(other) }
        end

        def portion_satisfied_by(*arguments)
          if satisfied_by?(*arguments)
            self
          else
            portions = predicates.map { |predicate| predicate.portion_satisfied_by(*arguments) }
            predicate_factory.conjunction(portions)
          end
        end

        def remainder_unsatisfied_by(*arguments)
          if satisfied_by?(*arguments)
            predicate_factory.contradiction
          else
            remainders = predicates.map { |predicate| predicate.remainder_unsatisfied_by(*arguments) }
            predicate_factory.disjunction(remainders)
          end
        end

        protected

        def or_with_disjunction(disjunction)
          disjunction.with_extra_predicates(predicates)
        end

        private

        def name
          'OR'
        end

        def subsumption?(first, second)
          first.generalization_of?(second)
        end

        def annihilation?(first, second)
          first.exhaustive_with?(second)
        end
      end
    end
  end
end
