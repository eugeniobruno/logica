class HaveSamePrefixOfLength < Logica::Predicates::Base
  def initialize(prefix_length)
    @prefix_length = prefix_length
  end

  def satisfied_by?(first_string, second_string)
    first_string[0...prefix_length] == second_string[0...prefix_length]
  end

  private

  attr_reader :prefix_length
end
