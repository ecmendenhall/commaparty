require 'nokogiri'

module CommaParty
  class HTML

    def initialize(markup)
      @markup = markup
    end

    def call
      build(@markup)
    end

    private

    def build(markup)
      Nokogiri::HTML::Builder.new do |doc|
        doc.html {|html| html << markup }
      end.to_html
    end
  end

end
