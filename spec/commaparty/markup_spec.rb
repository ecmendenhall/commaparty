require 'rspec'
require 'commaparty/markup'

describe CommaParty::Markup do

  describe 'Generating markup' do

    it 'generates a single tag' do
      html = described_class.new([:tag]).call
      expect(html).to eq("<tag/>")
    end

    it 'generates a single tag with an attribute' do
      html = described_class.new([:tag, {attribute: 'something'}]).call
      expect(html).to eq("<tag attribute=\"something\"/>")
    end

    it 'generates a single tag with a value' do
      html = described_class.new([:tag, 'value']).call
      expect(html).to eq("<tag>value</tag>")
    end

    it 'generates two sibling tags' do
      html = described_class.new([:tag1], [:tag2]).call
      expect(html).to eq("<tag1/><tag2/>")
    end

    it 'generates nested tags' do
      html = described_class.new([:theparent, [:tag1], [:tag2]]).call
      expect(html).to eq("<theparent>\n  <tag1/>\n  <tag2/>\n</theparent>")
    end

    it 'handles tags with the same names as ruby methods' do
      html = described_class.new([:parent]).call
      expect(html).to eq("<parent/>")
    end

  end
end
