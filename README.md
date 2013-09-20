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
By default all output is written to standard output. To use in your project:

     public class MyClass
        def initialize()
           log = LoggingFactory::DEFAULT_FACTORY.log(self.class)
        end
     end

This will instantiate a log with the default configuration, specified by `LoggingFactory::DEFAULT_LOG_CONFIGURATION`:

      {
         output: 'STDOUT',
         truncate: false,
         level: :debug,
         format: '[%d] %-5l [%c]: %m\n'
     }
     
To override this configuration you can modify a log instance like this:

     public class MyClass
        def initialize()
           log = LoggingFactory::DEFAULT_FACTORY.log(self.class, output: 'myproject.log')
        end
     end

Or create a new factory instant for use in your project:


     MY_LOG_FACTORY = LoggingFactory.create (
         output: 'myproject.log'
     )


This will create an factory that will use the `myproject.log` for logging. Other options which are no supplied will fall back to the default unless explicitly overridden.

     
## Examples
See `spec/my_log.log` for an example (run tests to generate this file).

Standard output:

<img src='https://github.com/nayyara-samuel/logging-factory/blob/master/img/stdout.png?raw=true' height='130'>

Log file:

    [2013-09-19 23:12:18] DEBUG [LogExample] This is a debug message
    [2013-09-19 23:12:18] INFO  [LogExample] This is an informational message
    [2013-09-19 23:12:18] WARN  [LogExample] This is an warning message
    [2013-09-19 23:12:18] ERROR [LogExample] This is an error message
    [2013-09-19 23:12:18] FATAL [LogExample] This is a fatal message

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
