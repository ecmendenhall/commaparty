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

  context 'converts ruby syntax to html string' do
    it { expect(CommaParty.markup [:script]).to eq "<script></script>" }
    it { expect(CommaParty.markup [:p, "hello"]).to eq "<p>hello</p>" }
    it { expect(CommaParty.markup [:p, [:em, "hello"]]).to eq "<p><em>hello</em></p>" }
    it { expect(CommaParty.markup [:span, {:class => "foo"}, "bar"]).to eq "<span class=\"foo\">bar</span>" }
    it { expect(CommaParty.markup [:div, {id: "email", class: "selected starred"}, "..."]).to eq "<div id=\"email\" class=\"selected starred\">...</div>" }
    it { expect(CommaParty.markup [:a, {:href => "http://github.com"}, "GitHub"]).to eq "<a href=\"http://github.com\">GitHub</a>"}

    context 'collections' do
      it { expect(CommaParty.markup [:ul, ['a','b'].map { |x| [:li, x]}]).to eq "<ul>\n<li>a</li>\n<li>b</li>\n</ul>"}
      it { expect(CommaParty.markup [:ul, (11...13).map { |n| [:li, n]}]).to eq "<ul>\n<li>11</li>\n<li>12</li>\n</ul>"}
    end

    context 'css shorthand' do
      it { expect(CommaParty.markup [:'p.hi', "hello"]).to eq "<p class=\"hi\">hello</p>" }
      it { expect(CommaParty.markup [:'p#hi', "hello"]).to eq "<p id=\"hi\">hello</p>" }
      it { expect(CommaParty.markup [:'p.hi.greet.left', "hello"]).to eq "<p class=\"hi greet left\">hello</p>" }
      it { expect(CommaParty.markup [:'p#hi.greet.left', "hello"]).to eq "<p class=\"greet left\" id=\"hi\">hello</p>" }
    end

    context 'different shaped trees' do
      it { expect(CommaParty.markup [:p, "Hello ", [:em, "World!"]]).to eq "<p>Hello <em>World!</em></p>" }
      it { expect(CommaParty.markup [:div, [:p, "Hello"], [:em, "World!"]]).to eq "<div>\n<p>Hello</p>\n<em>World!</em>\n</div>" }
    end
  end
end
