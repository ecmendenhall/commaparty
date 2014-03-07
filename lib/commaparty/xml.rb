require 'nokogiri'
require 'commaparty/markup'

module CommaParty
  class XML

    def self.build(markup)
      new(markup).call
    end

    def initialize(markup)
      @markup = CommaParty::Markup.new(markup)
    end

    def call
      @markup.builder.to_xml
    end

  end

end
