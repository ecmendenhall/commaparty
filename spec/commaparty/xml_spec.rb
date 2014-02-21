require 'rspec'
require 'commaparty/xml'
require 'commaparty/markup'

describe CommaParty::XML do

  let(:markup) { CommaParty::Markup.new([:parent, [:child1], [:child2]]).call }

  it 'creates XML from markup' do
    xml = described_class.new(markup).call
    expect(xml).to match(/<?xml/)
  end

end
