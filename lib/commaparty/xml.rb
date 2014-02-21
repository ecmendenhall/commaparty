require 'nokogiri'

module CommaParty
  class XML

    def self.build(markup)
      new(markup).call
    end

    def initialize(markup)
      @markup = markup
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
