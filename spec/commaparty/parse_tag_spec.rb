require 'rspec'
require 'commaparty/parse_tag'

describe CommaParty::ParseTag do

  describe 'Tag shortcuts' do

    it 'parses tags without shortcut syntax' do
      tag, attributes = described_class.new(:boring).call
      expect(tag).to eq(:boring)
      expect(attributes).to eq({})
    end

    it 'parses tags with a class shortcut' do
      tag, attributes = described_class.new(:'exciting.class').call
      expect(tag).to eq(:exciting)
      expect(attributes).to eq({class: 'class'})
    end

    it 'parses tags with an id shortcut' do
      tag, attributes = described_class.new(:'exciting#id').call
      expect(tag).to eq(:exciting)
      expect(attributes).to eq({id: 'id'})
    end

    it 'parses tags with a class shortcut and id shortcut' do
      tag, attributes = described_class.new(:'exciting.class#id').call
      expect(tag).to eq(:exciting)
      expect(attributes).to eq({class: 'class', id: 'id'})
    end

    it 'handles different orders' do
      tag, attributes = described_class.new(:'exciting#id.class').call
      expect(tag).to eq(:exciting)
      expect(attributes).to eq({class: 'class', id: 'id'})
    end
  end

end
