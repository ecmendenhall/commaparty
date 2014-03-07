module CommaParty
  class ParseTag

    def initialize(tag)
      @tag = tag[0]
    end

    def call
      [safe_tag_name, attributes]
    end

    private

    def attributes
      attributes = {}
      attributes = attributes.merge(class: classes.join(' ')) if classes
      attributes = attributes.merge(id: id) if id
      return attributes
    end

    def classes
      class_names = @tag.to_s.scan(/\.([^\.,#,\b]*)/)
      class_names if !class_names.empty?
    end

    def id
      ids = @tag.to_s.match(/\#([^\.,#,\b]*)/)
      ids.captures.first if ids
    end

    def tag_name
      @tag.to_s.match(/([^\.,#,\b]+)/).captures.first.to_sym
    end

    def safe_tag_name
      "#{tag_name.to_s}_".to_sym
    end

  end
end
