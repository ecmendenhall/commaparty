require 'nokogiri'
require 'commaparty/destructure_element'

module CommaParty
  class Markup

    def initialize(hiccup)
      @hiccup = [hiccup]
    end

    def call
      build(@hiccup).doc.to_html
    end

    def builder
      build(@hiccup)
    end

    def hiccup
      @hiccup.flatten(1)
    end

    private

    def build(elements)
      Nokogiri::XML::Builder.new do |doc|
        elements.each do |element|
          create_child(doc, element)
        end
      end
    end

    def create_child(node, element)
      tag, attributes, children = CommaParty::DestructureElement.new(element).call
      node.send(tag, attributes) {|n| make_nodes(n, children) }
    end

    def make_nodes(parent, children)
      children.each do |child|
        if child.is_a?(String) || child.is_a?(Fixnum) || child.nil?
          parent << child.to_s
        else
          create_child(parent, child)
        end
      end
    end

  end
end
