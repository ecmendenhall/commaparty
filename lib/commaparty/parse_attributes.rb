module CommaParty
  class ParseAttributes

    def initialize(element)
      @attributes = element[1]
    end

    def call
      if @attributes.is_a?(Hash)
        @attributes
      else
        {}
      end
    end

  end
end
