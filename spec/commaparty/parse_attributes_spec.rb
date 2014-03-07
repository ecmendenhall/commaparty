require 'rspec'
require 'commaparty/parse_attributes'

describe CommaParty::ParseAttributes do

  it 'extracts attributes when explicitly included' do
    attributes = described_class.new([:tag, {attribute: 'value'}]).call
    expect(attributes).to eq({attribute: 'value'})
  end

  it 'extracts attributes when not explicitly included' do
    attributes = described_class.new([:tag]).call
    expect(attributes).to eq({})
  end

  it 'extracts default attributes when the tag has a body' do
    attributes = described_class.new([:tag, 'body']).call
    expect(attributes).to eq({})
  end

end
