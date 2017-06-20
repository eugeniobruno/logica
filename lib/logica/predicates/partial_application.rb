module Logica
  module Predicates
    class PartialApplication < Base
      attr_reader :predicate, :first_arguments

      def initialize(predicate, first_arguments)
        @predicate = predicate
        @first_arguments = first_arguments
      end

      def satisfied_by?(*arguments)
        predicate.satisfied_by?(*(first_arguments + arguments))
      end

      def arity
        predicate.arity - first_arguments.size
      end

      def name_and_attributes
        "#{predicate.name_and_attributes}(#{first_arguments.join(', ')})"
      end

      private

      def do_partially_applied_with(more_arguments)
        predicate_factory.partial_application(predicate, first_arguments + more_arguments)
      end
    end
  end
end
