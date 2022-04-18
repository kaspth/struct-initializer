module RubyCoreExtStruct
  def struct(*names, keyword_init: false)
    include Initializer.new(names, keyword_init: keyword_init)
    names
  end

  class Initializer < Module
    def initialize(names, keyword_init: false)
      attr_reader *names
      arguments = names.map { "#{_1}#{":" if keyword_init}" }.join(",")

      class_eval <<~RUBY, __FILE__, __LINE__ + 1
        def initialize(#{arguments})
          #{names.map { "@#{_1} = #{_1}" }.join("\n")}
        end
      RUBY
    end
  end
end

Object.include RubyCoreExtStruct
