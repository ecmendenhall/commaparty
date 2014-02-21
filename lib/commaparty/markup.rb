require 'nokogiri'
require 'commaparty/destructure_element'

module CommaParty
  class Markup

    def initialize(*hiccup)
      @hiccup = hiccup
    end

    def call
      build(*@hiccup)
    end

    private

    def build(*elements)
      doc = Nokogiri::XML::Builder.new do |doc|
        doc.root do |root|
          elements.each do |element|
            create_child(root, element)
          end
        end
      end.doc.root.children.to_s
    end

    def create_child(node, element)
      tag, attributes, children = CommaParty::DestructureElement.new(element).call
      if children.empty? || children.first.is_a?(String)
        node.send(tag, attributes) {|n| n << children.first }
      else
        node.send(tag, attributes) {|n| n << build(*children) }
      end
    end

  end
end
