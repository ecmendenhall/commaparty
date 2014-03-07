require 'commaparty/parse_attributes'
require 'commaparty/parse_body'
require 'commaparty/parse_tag'

module CommaParty
  class DestructureElement

    def initialize(element)
      @element = element
    end

    def call
      normalize_element(@element)
    end

    private

    def normalize_element(element)
      tag, tag_attributes = CommaParty::ParseTag.new(element).call
      attributes = CommaParty::ParseAttributes.new(element).call
      body = CommaParty::ParseBody.new(element).call
      [tag,
       attributes.merge(tag_attributes),
       body]
    end

  end
end
