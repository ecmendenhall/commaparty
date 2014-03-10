require 'rspec'
require 'commaparty/markup'

describe CommaParty::Markup do

  describe 'Generating markup' do

    it 'generates a single tag' do
      html = described_class.new([:tag]).call
      expect(html).to eq("<tag></tag>\n")
    end

    it 'generates a single tag with an attribute' do
      html = described_class.new([:tag, {attribute: 'something'}]).call
      expect(html).to eq("<tag attribute=\"something\"></tag>\n")
    end

    it 'generates a single tag with a value' do
      html = described_class.new([:tag, 'value']).call
      expect(html).to eq("<tag>value</tag>\n")
    end

    it 'generates two sibling tags' do
      html = described_class.new([:div, [:tag1], [:tag2]]).call
      expect(html).to eq("<div>\n<tag1></tag1><tag2></tag2>\n</div>\n")
    end

    it 'generates nested tags' do
      html = described_class.new([:theparent, [:tag1], [:tag2]]).call
      expect(html).to eq("<theparent><tag1></tag1><tag2></tag2></theparent>\n")
    end

    it 'handles tags with the same names as ruby methods' do
      html = described_class.new([:parent]).call
      expect(html).to eq("<parent></parent>\n")
    end

    it 'handles tags with shortcut syntax' do
      html = described_class.new([:'tag.one.two.three#id']).call
      expect(html).to eq("<tag class=\"one two three\" id=\"id\"></tag>\n")
    end

    it 'handles seqs in the tag body' do
      html = described_class.new([:ul, ["one", "two", "three"].map {|n| [:li, n]}]).call
      expect(html).to eq("<ul>\n<li>one</li>\n<li>two</li>\n<li>three</li>\n</ul>\n")
    end

    it 'handles nils in the tag body' do
      html = described_class.new([:div, nil]).call
      expect(html).to eq("<div></div>\n")
    end

    it 'handles empty arrays in the tag body' do
      html = described_class.new([:div, [], 'he', [[]], 'llo']).call
      expect(html).to eq("<div>hello</div>\n")
    end
  end

  describe 'Generating builders' do

    it 'returns a Nokogiri builder' do
      builder = described_class.new([:div]).builder
      expect(builder.class).to eq(Nokogiri::XML::Builder)
    end

    it 'produces the same XML' do
      markup = described_class.new([:div, [:span, 'lol']])
      expect(markup.builder.doc.to_html).to eq(markup.call)
    end

  end

  describe 'Retrieving hiccup' do

    it 'returns its hiccup' do
      hiccup = described_class.new([:div, [:ul, (1..3).map {|n| [:li, n]}]]).hiccup
      expect(hiccup).to eq([:div, [:ul, [[:li, 1], [:li, 2], [:li, 3]]]])
    end

  end
end
