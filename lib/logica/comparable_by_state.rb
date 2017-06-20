module Logica
  module ComparableByState
    def ==(other)
      other.instance_of?(self.class) && other.state == state
    end
    alias_method :eql?, :==

    def hash
      state.hash
    end

    def state
      attributes
    end

    private

    def attributes
      instance_variables.each_with_object({}) do |name, h|
        h[name[1..-1].to_sym] = instance_variable_get(name)
      end
    end
  end
end
