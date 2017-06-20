module Logica
  module Predicates
    class AdHoc < Base
      attr_reader :name

      def initialize(name, &definition)
        @name = name
        define_singleton_method :satisfied_by?, &definition
      end

      def name_and_attributes
        "#{name}()"
      end
    end
  end
end
