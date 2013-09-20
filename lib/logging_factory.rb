require 'version'
require 'preconditions'
require 'logging'

#
# This class that contains code for initializing logs.
# @author: Nayyara Samuel (mailto: nayyara.samuel@opower.com)
#
# Patch so that certain checks can be gotten on a class using `include Preconditions`
module Preconditions
  def self.included(receiver)
    receiver.send :include, PreconditionMixinMethods
    receiver.send :include, PreconditionModuleClassMethods
  end
end

# Logging factory for logs
module LoggingFactory

  DEFAULT_LOG_CONFIGURATION = {
      output: 'STDOUT',
      truncate: false,
      level: :debug,
      format: '[%d] %-5l [%c] %m\n'
  }

  # Create a new logging factory
  def self.create(*params)
    Logger.new(*params)
  end

  # Main logger class
  class Logger
    include Preconditions

    attr_reader :log_configuration

    # Initializes this logger instance with teh format specified
    def initialize(config={})
      @log_configuration = DEFAULT_LOG_CONFIGURATION.merge(config)
    end

    # Returns a new log for the calling class with the supplied configuration
    def log(caller, config={})
      log_configuration = @log_configuration.merge(config)
      log = Logging.logger[caller]
      add_appenders(log, log_configuration)
      log
    end

    private
    def add_appenders(log, log_configuration)
      destination = log_configuration[:output]
      truncate = log_configuration[:truncate]
      level = log_configuration[:level].to_sym
      fmt = log_configuration[:format]

      if (destination == 'STDOUT')
        append_stdout_format(log, fmt)
      else
        append_file_format(log, destination, fmt, truncate)
      end

      valid_levels = [:debug, :error, :fatal, :warn, :info]
      check(level) do
        satisfies("Logging level must be one of {#{valid_levels.join(',')}}") do
          valid_levels.include?(level)
        end
      end
      log.level = level
      log
    end

    def append_file_format(log, destination, fmt, truncate=false)
      Logging.appenders.file(destination,
                             {
                                 file_name: destination,
                                 truncate: truncate ? true : false,
                                 layout: Logging.layouts.pattern(pattern: fmt)
                             })
      log.add_appenders(destination)
    end

    def append_stdout_format(log, fmt)
      Logging.color_scheme('bright',
                           levels: {
                               debug: :magenta,
                               info: :green,
                               warn: :yellow,
                               error: :red, fatal: [:white, :on_red]
                           },
                           date: :blue, logger: :cyan)
      Logging.appenders.stdout(
          'stdout',
          layout: Logging.layouts.pattern(
              pattern: fmt,
              color_scheme: 'bright'))
      log.add_appenders 'stdout'
    end
  end

  DEFAULT_FACTORY = LoggingFactory.create
end





