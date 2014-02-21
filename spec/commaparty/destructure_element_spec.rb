require 'rspec'
require 'commaparty/destructure_element'

describe CommaParty::DestructureElement do

  describe 'Normalizing elements' do

    it 'destructures an element with tag only' do
      tag, attributes, values = described_class.new([:lol]).call
      expect(tag).to eq(:lol_)
      expect(attributes).to eq({})
      expect(values).to eq([])
    end

    it 'destructures an element with tag, attributes, and values' do
      tag, attributes, values = described_class.new([:lol, {id: "the-id"}, "lol"]).call
      expect(tag).to eq(:lol_)
      expect(attributes).to eq({id: "the-id"})
      expect(values).to eq(["lol"])
    end

    it 'destructures an element with tag and attributes only' do
      tag, attributes, values = described_class.new([:lol, {id: "the-id"}]).call
      expect(tag).to eq(:lol_)
      expect(attributes).to eq({id: "the-id"})
      expect(values).to eq([])
    end

    it 'destructures an element with tag and values only' do
      tag, attributes, values = described_class.new([:lol, 'wut']).call
      expect(tag).to eq(:lol_)
      expect(attributes).to eq({})
      expect(values).to eq(['wut'])
    end

    it 'destructures an element with sibling children' do
      tag, attributes, values = described_class.new([:lol, {}, [:div], [:ul], [:other]]).call
      expect(tag).to eq(:lol_)
      expect(attributes).to eq({})
      expect(values).to eq([[:div], [:ul], [:other]])
    end
  end

end
