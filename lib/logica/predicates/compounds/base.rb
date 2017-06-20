module Logica
  module Predicates
    module Compounds
      class Base < Predicates::Base
        attr_reader :predicates

        def self.new_from_pair(first_predicate, second_predicate)
          new([first_predicate]).with_extra_predicate_last(second_predicate)
        end

        def self.new_from_list(predicates)
          predicates.reduce(internal_binary_operation) || neutral_element
        end

        def initialize(predicates)
          @predicates = predicates
          validate_composability
        end

        def with_extra_predicates(extra_predicates)
          extra_predicates.reduce(self) do |compound, extra_predicate|
            return compound if compound == absorbing_element
            compound.with_extra_predicate_last(extra_predicate)
          end
        end

        def with_extra_predicate_last(extra_predicate)
          with_extra_predicate(extra_predicate) do |subsumed, extra|
            predicates - subsumed + [extra]
          end
        end

        def arity
          predicates.first.arity
        end

        def name_and_attributes
          "#{name}(#{attributes_string})"
        end

        def without(predicate_or_predicates, options = {})
          without_predicates([predicate_or_predicates].flatten(1), options)
        end

        protected

        def without_predicates(preds, options = {})
          default_options = {
            recursive: false
          }
          options = default_options.merge(options)

          difference = predicates - preds

          remaining = if options[:recursive]
                        difference.flat_map { |pred| pred.without_predicates(preds, options) }
                      else
                        difference
                      end

          new_from_list(remaining)
        end

        private

        def validate_composability
          raise_composability_error unless predicates_are_composable?
        end

        def raise_composability_error
          raise ArgumentError, composability_error_message
        end

        def composability_error_message
          "cannot compose predicates #{predicates} (arity mismatch)"
        end

        def predicates_are_composable?
          predicates.map(&:arity).uniq.size <= 1
        end

        def annihilated_by?(other)
          predicates.any? { |own_predicate| annihilation?(own_predicate, other) }
        end

        def subsumes?(other)
          predicates.any? { |own_predicate| subsumption?(own_predicate, other) }
        end

        def with_extra_predicate_first(extra_predicate)
          with_extra_predicate(extra_predicate) do |subsumed, extra|
            [extra] + predicates - subsumed
          end
        end

        def with_extra_predicate(extra_predicate)
          return absorbing_element if annihilated_by?(extra_predicate)

          candidates = if subsumes?(extra_predicate)
                         predicates
                       else
                         predicates_subsumed = predicates.select { |pred| subsumption?(extra_predicate, pred) }
                         yield predicates_subsumed, extra_predicate
                       end
          candidates.one? ? candidates.first : new_with_predicates(candidates)
        end

        def predicates_satisfied_by(*arguments)
          predicates.select { |predicate| predicate.satisfied_by?(*arguments) }
        end

        def predicates_unsatisfied_by(*arguments)
          predicates.select { |predicate| predicate.unsatisfied_by?(*arguments) }
        end

        def new_with_predicates(new_predicates)
          self.class.new(new_predicates)
        end

        def new_from_list(preds)
          self.class.new_from_list(preds)
        end

        def absorbing_element
          self.class.absorbing_element
        end

        def attributes_string
          predicates.map(&:name_and_attributes).join(', ')
        end
      end
    end
  end
end
