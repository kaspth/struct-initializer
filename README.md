# Struct::Initializer

Reuse Struct.new's attr_reader and initialize generation in any class.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add struct-initializer

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install struct-initializer

## Usage

Ruby's `Struct` class allows auto-generating public `attr_reader`'s and an `initialize` method based on the passed attributes, like so:

```ruby
class Greeter < Struct.new(:name, :greeting)
end
```

But this only works with inheritance, so there's certain simple initializers that still have to be written manually. `Struct::Initializer` lifts the concept out of needing inheritance:

```ruby
class Greeter
  extend Struct::Initializer
  struct :name, :greeting
end
```

Another benefit, you can also have the `attr_reader`'s be marked private, even with keyword arguments:

```ruby
class Greeter
  extend Struct::Initializer
  private struct :name, :greeting, keyword_init: true
end
```

### Auto-include

If you want `struct` available on any object automatically, change the require to:

```ruby
gem "struct-initializer", require: "struct/initializer/autoinclude"
```

This extends `Object` with the `struct` macro, so it's automatically available on any object and `extend Struct::Initializer` from above isn't needed.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kaspth/struct-initializer.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
