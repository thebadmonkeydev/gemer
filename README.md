# Gemer [![Build Status](https://travis-ci.org/thebadmonkeydev/gemer.svg?branch=master)](https://travis-ci.org/thebadmonkeydev/gemer) [![Test Coverage](https://api.codeclimate.com/v1/badges/08c65482f9f0d9e80928/test_coverage)](https://codeclimate.com/github/thebadmonkeydev/gemer/test_coverage) [![Maintainability](https://api.codeclimate.com/v1/badges/08c65482f9f0d9e80928/maintainability)](https://codeclimate.com/github/thebadmonkeydev/gemer/maintainability)

A lightweight gem designed to provide tools for Ruby modules and gems

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'gemer'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gemer

## Usage

### Configuration

Any module can be made configurable with gemer with simple module extension:

```ruby
module MyModule
  include Gemer::Configurable

  # Default configuration values
  configure_defaults do |c|
    c.attr :force, false       # creates new configurable attribute with a default value
    c.attr :namespace          # creates a configurable attribute that is nil

    c.attr :engine, :rails, in: [:rails, :sinatra] # restrict the possible values for an attribute

    c.read_only :secret, 'foo' # creates a readonly attribute
  end
end
```

This will will make `MyModule` configurable:

```ruby
MyModule.configure do |c|
  c.force = true
  c.namespace = 'MYAPP'
  c.engine = :sinatra

  # c.engine = :foo   <= raises an error (not in possible values)
  # c.secret = 'bar'  <= raises an error (can't modify read-only attribute)
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/thebadmonkeydev/gemer. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the gemer project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/thebadmonkeydev/gemer/blob/master/CODE_OF_CONDUCT.md).
