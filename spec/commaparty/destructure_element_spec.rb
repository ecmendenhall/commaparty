require 'rspec'
require 'commaparty/destructure_element'

describe CommaParty::DestructureElement do

  describe 'Normalizing elements' do
    it 'destructures an element with tag only' do
      tag, attributes, body = described_class.new([:lol]).call
      expect(tag).to eq(:lol_)
      expect(attributes).to eq({})
      expect(body).to eq([])
    end

    it 'destructures an element with tag, attributes, and body' do
      tag, attributes, body = described_class.new([:lol, {id: "the-id"}, "lol"]).call
      expect(tag).to eq(:lol_)
      expect(attributes).to eq({id: "the-id"})
      expect(body).to eq(["lol"])
    end

    it 'destructures an element with tag and attributes only' do
      tag, attributes, body = described_class.new([:lol, {id: "the-id"}]).call
      expect(tag).to eq(:lol_)
      expect(attributes).to eq({id: "the-id"})
      expect(body).to eq([])
    end

    it 'destructures an element with tag and body only' do
      tag, attributes, body = described_class.new([:lol, 'wut']).call
      expect(tag).to eq(:lol_)
      expect(attributes).to eq({})
      expect(body).to eq(['wut'])
    end

    it 'destructures an element with sibling children' do
      tag, attributes, body = described_class.new([:lol, {}, [:div, {lol: 'wut'}], [:ul], [:other]]).call
      expect(tag).to eq(:lol_)
      expect(attributes).to eq({})
      expect(body).to eq([[:div, {lol: 'wut'}], [:ul], [:other]])
    end

    it 'destructures an element with an array of children' do
      tag, attributes, body = described_class.new([:ul, ["one", "two", "three"].map {|n| [:li, n]}]).call
      expect(tag).to eq(:ul_)
      expect(attributes).to eq({})
      expect(body).to eq([[:li, "one"], [:li, "two"], [:li, "three"]])
    end

    it 'wat' do
      tag, attributes, body = described_class.new([:p, [:em, "hello"]]).call
      expect(tag).to eq(:p_)
      expect(attributes).to eq({})
      expect(body).to eq([[:em, "hello"]])
    end
  end
end
