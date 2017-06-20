module Logica
  class PredicateFactory
    def conjunction(predicates)
      compound_from_list(predicates, conjunction_class)
    end

    def conjunction_from_pair(first_predicate, second_predicate)
      compound_from_pair(first_predicate, second_predicate, conjunction_class)
    end

    def disjunction(predicates)
      compound_from_list(predicates, disjunction_class)
    end

    def disjunction_from_pair(first_predicate, second_predicate)
      compound_from_pair(first_predicate, second_predicate, disjunction_class)
    end

    def negation(predicate)
      negation_class.new(predicate)
    end

    def at_least(minimum, predicates)
      if minimum <= 0
        tautology
      elsif minimum == 1
        disjunction(predicates)
      elsif minimum == predicates.size
        conjunction(predicates)
      elsif minimum >= predicates.size
        contradiction
      else
        at_least_class.new(minimum, predicates)
      end
    end

    def at_most(maximum, predicates)
      minimum   = predicates.size - maximum
      negations = predicates.map(&:negated)

      at_least(minimum, negations)
    end

    def between(minimum, maximum, predicates)
      at_least(minimum, predicates).and(at_most(maximum, predicates))
    end

    def exactly(amount, predicates)
      between(amount, amount, predicates)
    end

    def tautology
      tautology_class.new
    end

    def contradiction
      contradiction_class.new
    end

    def ad_hoc(name = 'anonymous', &definition)
      ad_hoc_class.new(name, &definition)
    end
    alias_method :from_block, :ad_hoc

    def partial_application(predicate, *first_arguments)
      partial_application_class.new(predicate, *first_arguments)
    end

    private

    def compound_from_list(predicates, compound_class)
      compound_class.new_from_list(predicates)
    end

    def compound_from_pair(first_predicate, second_predicate, compound_class)
      compound_class.new_from_pair(first_predicate, second_predicate)
    end

    def negation_class
      Predicates::Negation
    end

    def conjunction_class
      Predicates::Compounds::Conjunction
    end

    def disjunction_class
      Predicates::Compounds::Disjunction
    end

    def at_least_class
      Predicates::Compounds::AtLeast
    end

    def tautology_class
      Predicates::Tautology
    end

    def contradiction_class
      Predicates::Contradiction
    end

    def ad_hoc_class
      Predicates::AdHoc
    end

    def partial_application_class
      Predicates::PartialApplication
    end
  end
end
