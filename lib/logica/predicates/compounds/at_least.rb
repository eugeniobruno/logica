module Logica
  module Predicates
    module Compounds
      class AtLeast < Base
        attr_reader :amount

        def initialize(amount, predicates)
          super(predicates)
          @amount = amount
        end

        def satisfied_by?(*arguments)
          true_count = 0
          predicates_count = predicates.size
          predicates.each_with_index do |predicate, index|
            true_count += 1 if predicate.satisfied_by?(*arguments)
            return true if true_count >= amount
            remaining_predicates_count = predicates_count - (index + 1)
            return false if true_count + remaining_predicates_count < amount
          end
        end

        def and(other)
          other.and_with_at_least(self)
        end

        def and_with_other(other, options = {})
          default_options = {
            other_first: true
          }
          options = default_options.merge(options)

          subsumed = predicates.select { |pred| pred.generalization_of?(other) }
          new_amount = amount - subsumed.size
          new_predicates = predicates - subsumed
          new_at_least = predicate_factory.at_least(new_amount, new_predicates)

          pair = options[:other_first] ? [other, new_at_least] : [new_at_least, other]
          predicate_factory.conjunction_from_pair(*pair)
        end

        def portion_satisfied_by(*arguments)
          if satisfied_by?(*arguments)
            self
          else
            to_disjunction.portion_satisfied_by(*arguments)
          end
        end

        def remainder_unsatisfied_by(*arguments)
          if satisfied_by?(*arguments)
            predicate_factory.contradiction
          else
            unsatisfied_predicates = predicates_unsatisfied_by(*arguments)
            satisfied_count = predicates.size - unsatisfied_predicates.size
            new_amount = amount - satisfied_count

            predicate_factory.at_least(new_amount, unsatisfied_predicates)
          end
        end

        def to_disjunction
          @to_disjunction ||= begin
            combinations = predicates.combination(amount)

            conjunctions = combinations.map do |amount_preds|
              predicate_factory.conjunction(amount_preds)
            end

            predicate_factory.disjunction(conjunctions)
          end
        end

        def name_and_attributes
          "#{name}(#{amount}, [#{attributes_string}])"
        end

        private

        def new_from_list(preds)
          self.class.new(amount, preds)
        end

        def do_method_missing(name, *args, &block)
          to_disjunction.do_method_missing(name, *args, &block)
        end
      end
    end
  end
end
