require 'nokogiri'
require 'commaparty/markup'

module CommaParty
  class HTML

    def self.build(markup)
      new(markup).call
    end

    def initialize(markup)
      @markup = CommaParty::Markup.new(markup)
    end

    def call
      build(@markup.call)
    end

    private

    def build(markup)
      Nokogiri::HTML::Builder.new do |doc|
        doc.html {|html| html << markup }
      end.to_html
    end
  end
end
