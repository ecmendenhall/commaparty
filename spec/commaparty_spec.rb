require 'commaparty'

describe CommaParty do

  it 'has a helpful html method' do
    expect(CommaParty.html([:tag])).to match('<html><tag></tag></html>')
  end

  it 'has a helpful xml method' do
    expect(CommaParty.xml([:tag])).to match('<tag/>')
  end

  it 'has a helpful markup method' do
    expect(CommaParty.markup([:tag])).to match('<tag></tag>')
  end

end
