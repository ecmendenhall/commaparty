module CommaParty
  class ParseBody

    def initialize(element)
      @element = element
    end

    def call
      if nested?
        body.flatten(1)
      else
        body
      end
    end

    def body
      @body ||=
      if @element[1].is_a?(Hash)
        @element[2..-1]
      else
        @element[1..-1]
      end
    end

    def nested?
      body[0].is_a?(Array) && !body[0][0].is_a?(Symbol)
    end

  end
end
