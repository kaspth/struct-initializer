module RubyCoreExtStruct
  def struct(*names, keyword_init: false)
    include Initializer.new(names, keyword_init: keyword_init)
    names
  end

  class Initializer < Module
    def initialize(names, keyword_init: false)
      if keyword_init
        define_method :initialize do |**options|
          names.each { instance_variable_set "@#{_1}", options[_1] }
        end
      else
        define_method :initialize do |*args|
          names.each_with_index { instance_variable_set "@#{_1}", args[_2] }
        end
      end

      attr_reader *names
    end
  end
end

Object.include RubyCoreExtStruct
