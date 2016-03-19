module Render
  module HTML
    def html(title: 'untitled', body: '')
      "<!DOCTYPE html>
      <html>
        <head>
          <title>#{title}</title>
        </head>
        <body>#{body}</body>
      </html>"
    end

    def paragraph(text='')
      "<p>#{text}</p>"
    end

    def header(text="", level: 1)
      raise ArgumentError, "Invalid level: #{level}" unless level == 1 || level == 2 || level == 3 || level == 4 || level == 5 || level == 6
      "<h#{level}>#{text}</h#{level}>"
    end

    def italics(text='')
      "<em>#{text}</em>"
    end

    def bold(text='')
      "<strong>#{text}</strong>"
    end

    def link(text='', to:'#')
      "<a href=#{to.inspect}>#{text}</a>"
    end

    def image(source="")
      "<img src=#{source.inspect} />"
    end

    def preserve_formatting(text='')
      "<pre>#{text}</pre>"
    end

    def block(text='', classes: [])
      class_string = "class=" << classes.join(" ").inspect
      class_string = "" if classes.empty?
      "<div #{class_string}>#{text}</div>"
    end

    def inline(text='', classes: [])
      class_string = "class=" << classes.join(" ").inspect
      class_string = "" if classes.empty?
      "<span #{class_string}>#{text}</span>"
    end

    def list(ordered: false, items: [])
      tag = "ul"
      tag = "ol" if ordered
      inner = items.map { |item| "<li>#{item}</li>" }.join
      "<#{tag}>#{inner}</#{tag}>"
    end
  end
end
