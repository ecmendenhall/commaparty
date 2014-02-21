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
      tag, tag_attributes = CommaParty::ParseTag.new(element.shift).call
      tag = safe_tagname(tag)
      attributes = attribute(element) || {}
      [tag,
       attributes.merge(tag_attributes),
       element]
    end

    def safe_tagname(tag)
      "#{tag.to_s}_".to_sym
    end

    def attribute(element)
      if element.first && element.first.is_a?(Hash)
        element.shift
      end
    end

  end
end
