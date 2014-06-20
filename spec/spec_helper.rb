# encoding: UTF-8
require 'simplecov'

SimpleCov.start do
  add_filter 'spec/'
  add_filter 'rdoc/'
  add_filter 'results/'
  add_filter 'coverage/'
end

require 'rspec'
require 'rspec/mocks'
require_relative '../lib/logging_factory'

# A class to allow easy reference of files with a given base path
class FileAccessor
  attr_accessor :base_path

  # Options should have a list of parts which will be appended together to give the base path
  def initialize(*options)
    @base_path = File.join(options.map { |f| f.to_s })
  end

  # Access specific file in the base path
  def [](file_name)
    File.join(@base_path, file_name)
  end

  # Read the given file
  def read(file_name)
    File.read(File.join(@base_path, file_name))
  end

  # Delete all files in the directory
  def delete_files(pattern = '*.log')
    FileUtils.rm_rf Dir.glob(File.join(base_path, pattern))
  end
end

RSpec.configure do |config|

  config.before(:suite) do
    file_accessor = FileAccessor.new(:spec)
    file_accessor.delete_files
  end

end
