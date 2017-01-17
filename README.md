# Nav::Logger

Nav's logger

## Installation

Add this line to your application's Gemfile:

```ruby
gem "nav-logger"
```

And then execute:

`$ bundle`

Or install it yourself as:

`$ gem install nav-logger`

## Usage

### Rails

If you only want to tag your Rails logs with request and session ids, you just need to include the gem in your gemfile.

If you also want logs being sent to the aggregator, you need add the following to the application.rb:
```ruby
config.middleware.use Nav::Logger::RequestLogger
```

#### Rack

After installing gem into rack app, add in the config.ru
```ruby
use Nav::Logger::RequestTag
use Nav::Logger::RequestLogger
```
_Make sure RequestTag comes before RequestLogger_

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/creditera/nav-logger. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
