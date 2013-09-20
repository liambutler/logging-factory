# LoggingFactory

A wrapper around the [`logging` gem](https://github.com/TwP/logging) that makes instantiating logs easier. Also has a number of presets for file and standard output logging. 

## Installation

Add this line to your application's Gemfile:

    gem 'logging_factory'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install logging_factory

## Usage
By default all output is written to standard output.

## Examples

Standard output:

<img src='https://github.va.opower.it/nayyara-samuel/logging_factory/blob/master/img/stdout.png?raw=true' height='130'>

Log file:

    [2013-09-19 23:12:18] DEBUG LogExample: This is a debug message
    [2013-09-19 23:12:18] INFO  LogExample: This is an informational message
    [2013-09-19 23:12:18] WARN  LogExample: This is an warning message
    [2013-09-19 23:12:18] ERROR LogExample: This is an error message
    [2013-09-19 23:12:18] FATAL LogExample: This is a fatal message

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
