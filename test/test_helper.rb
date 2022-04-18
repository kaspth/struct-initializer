# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "struct/initializer"

if ENV["AUTOINCLUDE"]
  puts "Running tests with AUTOINCLUDE"
  require "struct/initializer/autoinclude"
end

require "minitest/autorun"

class Struct::Initializer::BaseTest < Minitest::Test
  private
    def prepare_struct(&block)
      flunk unless ENV["AUTOINCLUDE"]
      Class.new do
        extend Struct::Initializer unless respond_to?(:struct)
        class_eval(&block)
      end
    end
end
