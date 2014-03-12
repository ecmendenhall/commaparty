require 'rspec'
require 'commaparty/markup'

describe CommaParty::Markup do

  describe 'Generating markup' do

    it 'generates a single tag' do
      html = described_class.new([:tag]).call
      expect(html).to eq("<tag></tag>\n")
    end

    it 'generates a single tag with an attribute' do
      html = described_class.new([:tag, {attribute: 'something'}]).call
      expect(html).to eq("<tag attribute=\"something\"></tag>\n")
    end

    it 'generates a single tag with a value' do
      html = described_class.new([:tag, 'value']).call
      expect(html).to eq("<tag>value</tag>\n")
    end

    it 'generates two sibling tags' do
      html = described_class.new([:div, [:tag1], [:tag2]]).call
      expect(html).to eq("<div>\n<tag1></tag1><tag2></tag2>\n</div>\n")
    end

    it 'generates nested tags' do
      nested = [:parent, [:tag1, [:tag2, [:tag3, [:tag4, 'deep', [:tag5, 'nesting']]]]]]
      html = described_class.new(nested).call
      expect(html).to eq("<parent><tag1><tag2><tag3><tag4>deep<tag5>nesting</tag5></tag4></tag3></tag2></tag1></parent>\n")
    end

    it 'handles tags with the same names as ruby methods' do
      html = described_class.new([:parent]).call
      expect(html).to eq("<parent></parent>\n")
    end

    it 'handles tags with shortcut syntax' do
      html = described_class.new([:'tag.one.two.three#id']).call
      expect(html).to eq("<tag class=\"one two three\" id=\"id\"></tag>\n")
    end

    it 'handles seqs in the tag body' do
      html = described_class.new([:ul, ["one", "two", "three"].map {|n| [:li, n]}]).call
      expect(html).to eq("<ul>\n<li>one</li>\n<li>two</li>\n<li>three</li>\n</ul>\n")
    end

    it 'handles nils in the tag body' do
      html = described_class.new([:div, nil]).call
      expect(html).to eq("<div></div>\n")
    end

    it 'handles empty arrays in the tag body' do
      html = described_class.new([:div, [], 'he', [[]], 'llo']).call
      expect(html).to eq("<div>hello</div>\n")
    end
  end

  describe 'Generating builders' do

    it 'returns a Nokogiri builder' do
      builder = described_class.new([:div]).builder
      expect(builder.class).to eq(Nokogiri::XML::Builder)
    end

    it 'produces the same XML' do
      markup = described_class.new([:div, [:span, 'lol']])
      expect(markup.builder.doc.to_html).to eq(markup.call)
    end

  end

  describe 'Retrieving hiccup' do

    it 'returns its hiccup' do
      hiccup = described_class.new([:div, [:ul, (1..3).map {|n| [:li, n]}]]).hiccup
      expect(hiccup).to eq([:div, [:ul, [[:li, 1], [:li, 2], [:li, 3]]]])
    end

  end

  describe 'Hiccup specs' do

    describe 'basic tags' do
      specify { expect(described_class.new([:div]).call).to eq("<div></div>\n") }
      specify { expect(described_class.new(["div"]).call).to eq("<div></div>\n") }
    end

    describe 'tag syntax sugar' do
      specify { expect(described_class.new([:'div#foo']).call).to eq("<div id=\"foo\"></div>\n") }
      specify { expect(described_class.new([:'div.foo']).call).to eq("<div class=\"foo\"></div>\n") }
      specify { expect(described_class.new([:'div.foo', ["bar", "baz"].join]).call).
                to eq("<div class=\"foo\">barbaz</div>\n") }
      specify { expect(described_class.new([:'div.a.b']).call).to eq("<div class=\"a b\"></div>\n") }
      specify { expect(described_class.new([:'div.a.b.c']).call).to eq("<div class=\"a b c\"></div>\n") }
      specify { expect(described_class.new([:'div#foo.bar.baz']).call).
                to eq("<div class=\"bar baz\" id=\"foo\"></div>\n") }
    end

    describe 'tag contents' do
      specify { expect(described_class.new([:div]).call).to eq("<div></div>\n") }
      specify { expect(described_class.new([:h1]).call).to eq("<h1></h1>\n") }
      specify { expect(described_class.new([:script]).call).to eq("<script></script>\n") }
      specify { expect(described_class.new([:text]).call).to eq("<text></text>\n") }
      specify { expect(described_class.new([:a]).call).to eq("<a></a>\n") }
      specify { expect(described_class.new([:iframe]).call).to eq("<iframe></iframe>\n") }
      specify { expect(described_class.new([:title]).call).to eq("<title></title>\n") }
      specify { expect(described_class.new([:section]).call).to eq("<section></section>\n") }
      specify { expect(described_class.new([:select]).call).to eq("<select></select>\n") }
      specify { expect(described_class.new([:object]).call).to eq("<object></object>\n") }
      specify { expect(described_class.new([:video]).call).to eq("<video></video>\n") }
    end

    describe 'tags containing text' do
      specify { expect(described_class.new([:text, "Lorem Ipsum"]).call).
                to eq("<text>Lorem Ipsum</text>\n") }
    end

    describe 'contents are concatenated' do
      specify { expect(described_class.new([:body, "foo", "bar"]).call).
                to eq("<body>foobar</body>\n") }
      specify { expect(described_class.new([:body, [:p], [:br]]).call).
                to eq("<body>\n<p></p>\n<br>\n</body>\n") }
    end

    describe 'seqs are expanded' do
      specify { expect(described_class.new([:body, ["foo", "bar"]]).call).
                to eq("<body>foobar</body>\n") }
    end

    describe 'tags can contain tags' do
      specify { expect(described_class.new([:div, [:p]]).call).
                to eq("<div><p></p></div>\n") }
      specify { expect(described_class.new([:div, [:b]]).call).
                to eq("<div><b></b></div>\n") }
      specify { expect(described_class.new([:p, [:span, [:a, "foo"]]]).call).
                to eq("<p><span><a>foo</a></span></p>\n") }
    end

    describe 'tag with blank attribute map' do
      specify { expect(described_class.new([:xml, {}]).call).
                to eq("<xml></xml>\n") }
    end

    describe 'tag with populated attribute map' do
      specify { expect(described_class.new([:xml, {a: "1", b: "2"}]).call).
                to eq("<xml a=\"1\" b=\"2\"></xml>\n") }
      specify { expect(described_class.new([:img, {id: "foo"}]).call).
                to eq("<img id=\"foo\">\n") }
    end

    describe 'tag content can be vars' do
      var = "foo"
      specify { expect(described_class.new([:span, var]).call).
                to eq("<span>foo</span>\n") }
    end

    describe 'tag content can be function calls' do
      specify { expect(described_class.new([:span, [1, 1].inject(:+)]).call).
                to eq("<span>2</span>\n") }
      specify { expect(described_class.new([:span, {foo: "bar"}.fetch(:foo)]).call).
                to eq("<span>bar</span>\n") }
    end

    describe 'attributes can contain vars' do
      var = "foo"
      specify { expect(described_class.new([:xml, {x: var}]).call).
                to eq("<xml x=\"foo\"></xml>\n") }
      specify { expect(described_class.new([:xml, {x: var}, "bar"]).call).
                to eq("<xml x=\"foo\">bar</xml>\n") }
    end

    describe 'attributes can contain function calls' do

      def foo
        "foo"
      end

      specify { expect(described_class.new([:img, {src: ["/foo", "/bar"].join}]).call).
                to eq("<img src=\"/foo/bar\">\n") }
      specify { expect(described_class.new([:div, {id: ["a", "b"].join}, foo]).call).
                to eq("<div id=\"ab\">foo</div>\n") }
    end

  end
end
