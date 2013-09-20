require 'load_path'

LoadPath.configure do
  add sibling_directory('lib')
  require 'logging_factory'
end

class LogExample

  def initialize()
    @log = Opower::LOGGING_FACTORY.log(self.class)
  end

  def print_debug_message
    @log.debug "This is a debug message"
  end

  def print_info_message
    @log.info "This is an informational message"
  end

  def print_warn_message
    @log.warn "This is an warning message"
  end

  def print_error_message
    @log.error "This is an error message"
  end

  def print_fatal_message
    @log.fatal "This is a fatal message"
  end

end

log_example = LogExample.new
log_example.print_debug_message
log_example.print_info_message
log_example.print_warn_message
log_example.print_error_message
log_example.print_fatal_message
