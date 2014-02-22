require 'rspec'
require 'commaparty/html'
require 'commaparty/markup'

describe CommaParty::HTML do

  let(:markup) { [:parent, [:child1], [:child2]] }

  it 'creates HTML from markup' do
    html = described_class.new(markup).call
    expect(html).to match(/<!DOCTYPE html/)
  end

end
