require 'openhouse'

require 'logica/version'

require 'logica/comparable_by_state'

require 'logica/predicates/base'
require 'logica/predicates/ad_hoc'
require 'logica/predicates/partial_application'
require 'logica/predicates/negation'
require 'logica/predicates/tautology'
require 'logica/predicates/contradiction'

require 'logica/predicates/compounds/base'
require 'logica/predicates/compounds/conjunction'
require 'logica/predicates/compounds/disjunction'
require 'logica/predicates/compounds/at_least'

require 'logica/predicate_factory'

module Logica
  def self.predicate_factory
    @predicate_factory ||= PredicateFactory.new
  end
end
