# encoding: UTF-8
require_relative './spec_helper'

describe LoggingFactory::Logger do

  context 'log to file' do

    let(:file_accessor) { FileAccessor.new(:spec) }
    let(:log_file) { 'my_log.log' }
    let(:log) { LoggingFactory::DEFAULT_FACTORY.log('LogExample', output: file_accessor['my_log.log']) }
    let(:debug_message) { 'This is a debug message' }
    let(:info_message) { 'This is an info message' }
    let(:warn_message) { 'This is a warn message' }
    let(:error_message) { 'This is an error message' }
    let(:fatal_message) { 'This is a fatal message' }
    let(:time_regex) { /\[\d{4}(\-\d{2}){2} \d{2}(\:\d{2}){2}\]/ }

    before do
      log.debug(debug_message)
      log.info(info_message)
      log.warn(warn_message)
      log.error(error_message)
      log.fatal(fatal_message)
    end

    it 'logs messages correctly with log levels' do
      log_content = file_accessor.read('my_log.log')
      log_lines = log_content.split("\n")
      expect(log_lines[0]).to match(/^#{time_regex} DEBUG \[LogExample\] #{debug_message}$/)
      expect(log_lines[1]).to match(/^#{time_regex} INFO  \[LogExample\] #{info_message}$/)
      expect(log_lines[2]).to match(/^#{time_regex} WARN  \[LogExample\] #{warn_message}$/)
      expect(log_lines[3]).to match(/^#{time_regex} ERROR \[LogExample\] #{error_message}$/)
      expect(log_lines[4]).to match(/^#{time_regex} FATAL \[LogExample\] #{fatal_message}$/)
    end

  end
end
