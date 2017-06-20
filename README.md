# Logica

Logica is a reusable implementation of the Specification design pattern, or a framework to manage predicates of arbitrary complexity.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'logica'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install logica

## Usage

Here is a simple example:

```ruby
class IsEven < Logica::Predicates::Base

  def satisfied_by?(number)
    number.even?
  end

end

class IsGreaterThan < Logica::Predicates::Base

  attr_reader :threshold

  def initialize(threshold)
    @threshold = threshold
  end

  def satisfied_by?(number)
    number > threshold
  end

end

is_even = IsEven.new

is_even.satisfied_by?(1)    # false
is_even.satisfied_by?(2)    # true

is_even.negated.satisfied_by?(3)    # true
is_even.negated.satisfied_by?(4)    # false

is_greater_than_five = IsGreaterThan.new(5)

is_greater_than_five.satisfied_by?(5) # false
is_greater_than_five.satisfied_by?(6) # true

is_even.and(is_greater_than_five).satisfied_by?(6) # true
is_even.and(is_greater_than_five).satisfied_by?(7) # false

is_even.or(is_greater_than_five).satisfied_by?(8) # true
is_even.or(is_greater_than_five).satisfied_by?(9) # true
```

More examples that show many more features can be found in the test files.


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/eugeniobruno/logica. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

