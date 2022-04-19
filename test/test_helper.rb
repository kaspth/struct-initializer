# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "struct/initializer"

if ENV["CORE_EXT"]
  puts "Running tests with CORE_EXT"
  require "struct/initializer/core_ext"
end

require "minitest/autorun"

class Struct::Initializer::BaseTest < Minitest::Test
  private
    def prepare_struct(&block)
      Class.new do
        extend Struct::Initializer unless respond_to?(:struct)
        class_eval(&block)
      end
    end
end
