require 'nokogiri'
require 'commaparty/destructure_element'

module CommaParty
  class Markup

    def initialize(hiccup)
      @hiccup = [hiccup]
    end

    def call
      build(@hiccup)
    end

    private

    def build(elements)
      doc = Nokogiri::XML::Builder.new do |doc|
        doc.root do |root|
          elements.each do |element|
            create_child(root, element)
          end
        end
      end.doc.root.children.to_html
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
