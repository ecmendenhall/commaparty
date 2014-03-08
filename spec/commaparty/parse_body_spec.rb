require 'rspec'
require 'commaparty/parse_body'

describe CommaParty::ParseBody do

  it 'returns [] for tags with no body' do
    body = described_class.new([:tag]).call
    expect(body).to eq([])
  end

  it 'returns the body for tags with a body' do
    body = described_class.new([:tag, 'body']).call
    expect(body).to eq(['body'])
  end

  it 'returns [] for tags with attributes and no body' do
    body = described_class.new([:tag, {}]).call
    expect(body).to eq([])
  end

  it 'returns the body for tags with attributes and a body' do
    body = described_class.new([:tag, {}, 'body']).call
    expect(body).to eq(['body'])
  end

  it 'returns the body for tags with attributes and a body' do
    body = described_class.new([:p, [:em, "hello"]]).call
    expect(body).to eq([[:em, 'hello']])
  end

  it 'returns the body for tags with attributes and a body' do
    body = described_class.new([:p, "Hello ", [:em, "World!"]]).call
    expect(body).to eq(["Hello ", [:em, "World!"]])
  end

end
