require 'nokogiri'
require 'commaparty/markup'

module CommaParty
  class XML

    def self.build(markup)
      new(markup).call
    end

    def initialize(markup)
      @markup = CommaParty::Markup.new(markup).call
    end

    def call
      build(@markup)
    end

    private

    def build(markup)
      Nokogiri::XML::Builder.new do |doc|
        doc << markup
      end.to_xml
    end
  end

end
