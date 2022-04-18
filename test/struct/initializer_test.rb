# frozen_string_literal: true

require "test_helper"

class Struct::InitializerTest < Minitest::Test
  def test_struct_initializer_with_positional_arguments
    klass = prepare_struct do
      struct :name, :greeting
    end

    struct = klass.new("glenn", "heyo")
    assert_equal "glenn", struct.name
    assert_equal "heyo",  struct.greeting
  end

  def test_struct_initializer_positional_argument_strictness
    klass = prepare_struct do
      struct :name, :greeting
    end

    assert_raises { klass.new }
    assert_raises { klass.new("glenn") }
    assert_raises { klass.new("glenn", "heyo", "too much") }
  end

  def test_struct_initializer_keyword_argument_strictness
    klass = prepare_struct do
      struct :name, :greeting, keyword_init: true
    end

    assert_raises { klass.new }
    assert_raises { klass.new(name: "glenn") }
    assert_raises { klass.new(name: "glenn", greeting: "heyo", one_more: "for the road") }
  end

  def test_struct_initializer_with_keyword_arguments
    klass = prepare_struct do
      struct :name, :greeting, keyword_init: true
    end

    struct = klass.new(name: "glenn", greeting: "heyo")
    assert_equal "glenn", struct.name
    assert_equal "heyo",  struct.greeting
  end

  def test_struct_initializer_with_extension
    klass = prepare_struct do
      struct :name
      attr_reader :greeting

      def initialize(name, greeting = "heyo")
        super(name)
        @greeting = greeting
      end
    end

    struct = klass.new("glenn")
    assert_equal "glenn", struct.name
    assert_equal "heyo",  struct.greeting
  end

  def test_struct_initializer_with_visibility_change
    klass = prepare_struct do
      private struct :name, :greeting, keyword_init: true # Use funkiest syntax to test we're one-liner capable.
    end

    struct = klass.new(name: "glenn", greeting: "heyo")
    assert_raises(NoMethodError) { struct.name }
    assert_raises(NoMethodError) { struct.greeting }

    assert_equal "glenn", struct.send(:name)
    assert_equal "heyo",  struct.send(:greeting)
  end

  private
    def prepare_struct(&block)
      Class.new do
        extend Struct::Initializer
        class_eval(&block)
      end
    end
end
