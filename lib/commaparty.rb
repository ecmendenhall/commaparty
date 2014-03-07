require "commaparty/html"
require "commaparty/markup"
require "commaparty/version"
require "commaparty/xml"

module CommaParty

  def self.html(hiccup)
    CommaParty::HTML.new(hiccup).call
  end

  def self.xml(hiccup)
    CommaParty::XML.new(hiccup).call
  end

  def self.markup(hiccup)
    CommaParty::Markup.new(hiccup).call
  end

  def self.builder(hiccup)
    CommaParty::Markup.new(hiccup).builder
  end

end

