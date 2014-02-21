require 'rspec'
require 'commaparty/html'
require 'commaparty/markup'

describe CommaParty::HTML do

  let(:markup) { CommaParty::Markup.new([:parent, [:child1], [:child2]]).call }

  it 'creates HTML from markup' do
    html = described_class.new(markup).call
    expect(html).to match(/<!DOCTYPE html/)
  end

  it 'has a class method' do
    html = described_class.build(markup)
    expect(html).to eq(described_class.new(markup).call)
  end

end
