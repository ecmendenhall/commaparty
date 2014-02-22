require 'rspec'
require 'commaparty/xml'
require 'commaparty/markup'

describe CommaParty::XML do

  let(:markup) { [:parent, [:child1], [:child2]] }

  it 'creates XML from markup' do
    xml = described_class.new(markup).call
    expect(xml).to match(/<?xml/)
  end

end
