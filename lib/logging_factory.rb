require 'load_path'

LoadPath.configure do
  add child_directory('logging_factory')

  require 'version'
  require 'preconditions'
  require 'logging'
end

#
# This class that contains code for initializing logs.
# Author: Nayyara Samuel (nayyara.samuel@opower.com)
#

# Patch so that certain checks can be gotten on a class using `include Preconditions`
module Preconditions
  def self.included(receiver)
    receiver.send :include, PreconditionMixinMethods
    receiver.send :include, PreconditionModuleClassMethods
  end
end

# Logging factory for logs
module Opower
  DEFAULT_LOG_CONFIGURATION = {
      output: 'STDOUT',
      truncate: false,
      level: :debug,
      format: '[%d] %-5l %c: %m\n'
  }

  class LoggingFactory
    include Preconditions
    attr_accessor :log_configuration

    # Initializes this logger instance with teh format specified
    def initialize(config={})
      final_config = DEFAULT_LOG_CONFIGURATION.merge(config)
      @log_configuration = final_config
    end

    def log_configuration=(config)
      final_config = DEFAULT_LOG_CONFIGURATION.merge(config)
      @log_configuration = final_config
    end

    # Returns a new log for the calling class with the supplied configuration
    def log(caller)
      log = Logging.logger[caller]
      add_appenders(log)
      log
    end

    private
    def add_appenders(log)
      destination = @log_configuration[:output]
      truncate = @log_configuration[:truncate]
      level = @log_configuration[:level].to_sym

      if (destination == 'STDOUT')
        append_stdout_format(log)
      else
        append_file_format(log, destination, truncate)
      end

      check(level) do
        satisfies("Logging level must be one of {debug, info, warn}") do
          level == :debug || level == :info || level == :warn
        end
      end
      log.level = level
      log
    end

    def append_file_format(log, destination, truncate=false)
      Logging.appenders.file(destination,
                             {
                                 file_name: destination,
                                 truncate: truncate ? true : false,
                                 layout: Logging.layouts.pattern(
                                     pattern: @log_configuration[:format]
                                 )
                             }
      )
      log.add_appenders(destination)
    end

    def append_stdout_format(log)
      Logging.color_scheme('bright',
                           levels: {
                               debug: :magenta, info: :green, warn: :yellow, error: :red, fatal: [:white, :on_red]
                           },
                           date: :blue, logger: :cyan
      )
      Logging.appenders.stdout(
          'stdout',
          layout: Logging.layouts.pattern(
              pattern: @log_configuration[:format],
              color_scheme: 'bright'
          )
      )
      log.add_appenders 'stdout'
    end
  end

  LOGGING_FACTORY = LoggingFactory.new
end

