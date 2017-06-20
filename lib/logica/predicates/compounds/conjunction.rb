module Logica
  module Predicates
    module Compounds
      class Conjunction < Base
        class << self
          def internal_binary_operation
            :and
          end

          def neutral_element
            predicate_factory.tautology
          end

          def absorbing_element
            predicate_factory.contradiction
          end
        end

        def satisfied_by?(*arguments)
          predicates.all? { |predicate| predicate.satisfied_by?(*arguments) }
        end

        def and(other)
          other.and_with_conjunction(self)
        end

        def and_with_other(other)
          with_extra_predicate_first(other)
        end

        def specialization_of?(other)
          other.generalization_of_conjunction?(self)
        end

        def specialization_of_other?(other)
          predicates.any? { |predicate| predicate.specialization_of?(other) }
        end

        def portion_satisfied_by(*arguments)
          satisfied_predicates = predicates_satisfied_by(*arguments)
          predicate_factory.conjunction(satisfied_predicates)
        end

        def remainder_unsatisfied_by(*arguments)
          unsatisfied_predicates = predicates_unsatisfied_by(*arguments)
          if unsatisfied_predicates.empty?
            predicate_factory.contradiction
          else
            predicate_factory.conjunction(unsatisfied_predicates)
          end
        end

        protected

        def and_with_conjunction(conjunction)
          conjunction.with_extra_predicates(predicates)
        end

        private

        def name
          'AND'
        end

        def subsumption?(first, second)
          first.specialization_of?(second)
        end

        def annihilation?(first, second)
          first.disjoint_with?(second)
        end
      end
    end
  end
end
