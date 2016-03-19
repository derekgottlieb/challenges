require 'html_erb_css/challenge'

RSpec.describe 'Render::HTML' do
  if defined? Render::HTML
    include Render::HTML
  end

  def parse(document_fragment)
    fragment = Nokogiri::HTML::DocumentFragment.parse(document_fragment)
    assert_equal 1, fragment.children.length
    fragment.children[0]
  end

  it 'is a module so that we can include it to gain access to its methods, without putting them on Object' do
    assert_equal Module, Render.class
    assert_equal Module, Render::HTML.class
  end

  describe '#html' do
    it 'sets an html doctype' do
      text = html() # <-- you need to define this
      assert_equal '<!DOCTYPE html>', text[0, 15]
    end

    it 'has a highest level element of html' do
      doc = Nokogiri::HTML(html())
      assert_equal 'html', doc.at_css('html').name
    end

    it 'has a head within the html' do
      doc = Nokogiri::HTML(html())
      assert_equal 'head', doc.at_css('html head').name
    end

    it 'has a body' do
      doc = Nokogiri::HTML(html())
      assert_equal 'body', doc.at_css('html body').name
    end

    it 'can be given a title to add' do
      doc = Nokogiri::HTML(html(title: 'hello there'))
      assert_equal 'hello there', doc.title
    end

    it 'defaults the title to "untitled"' do
      doc = Nokogiri::HTML(html())
      assert_equal 'untitled', doc.title
    end

    it 'can be given text to place within the body' do
      doc = Nokogiri::HTML(html(body: 'abc'))
      assert_equal 'abc', doc.at_css('html body').text
    end

    it 'defaults the body to empty' do
      doc = Nokogiri::HTML(html())
      assert_equal '', doc.at_css('html body').text
    end
  end

  describe '#paragraph' do
    it 'renders a paragraph tag' do
      assert_equal 'p', parse(paragraph()).name
    end

    it 'places the text within the paragraph' do
      element = parse paragraph('this is the body for the paragraph')
      assert_equal 'this is the body for the paragraph', element.text
    end

    it 'defaults the paragraph text to empty' do
      element = parse paragraph()
      assert_equal '', element.text
    end
  end

  describe '#header' do
    it 'returns an h at the specified level' do
      assert_equal 'h1', parse(header(level: 1)).name
      assert_equal 'h2', parse(header(level: 2)).name
      assert_equal 'h3', parse(header(level: 3)).name
      assert_equal 'h4', parse(header(level: 4)).name
      assert_equal 'h5', parse(header(level: 5)).name
      assert_equal 'h6', parse(header(level: 6)).name
    end

    it 'defaults the level to 1' do
      assert_equal 'h1', parse(header()).name
    end

    it 'raises an ArgumentError if the level is not 1, 2, 3, 4, 5, or 6' do
      assert_raises(ArgumentError) { header level: 0 }
      assert_raises(ArgumentError) { header level: 7 }
      assert_raises(ArgumentError) { header level: 1.5 }
    end

    it 'renders the text' do
      element = parse header('yo this is a header', level: 1)
      assert_equal 'yo this is a header', element.text
    end

    it 'defaults the text to an empty string' do
      assert_equal '', parse(header()).text
    end
  end


  describe '#italics' do
    it 'returns an em tag' do
      assert_equal 'em', parse(italics()).name
    end
    it 'renders the text' do
      assert_equal 'hello world', parse(italics('hello world')).text
    end
    it 'defaults the text to an empty string' do
      assert_equal '', parse(italics()).text
    end
  end

  describe '#bold' do
    it 'returns a strong tag' do
      assert_equal 'strong', parse(bold()).name
    end
    it 'renders the text' do
      assert_equal 'hello world', parse(bold('hello world')).text
    end
    it 'defaults the text to an empty string' do
      assert_equal '', parse(bold()).text
    end
  end

  describe '#link' do
    let(:returned) { link 'hello world', to: 'http://somewhere.com' }
    let(:parsed)   { parse returned }
    it 'returns an a tag' do
      assert_equal 'a', parsed.name
    end
    it 'renders the text' do
      assert_equal 'hello world', parsed.text
    end
    it 'defaults the text to an empty string' do
      assert_equal '', parse(link()).text
    end
    it 'accepts a location to link to' do
      assert_equal 'http://somewhere.com', parsed[:href]
    end
    it 'defaults the location to a hash (empty document fragment)' do
      assert_equal '#', parse(link())[:href]
    end
  end

  describe '#image' do
    it 'returns an img tag' do
      assert_equal 'img', parse(image()).name
    end
    it 'accepts a source' do
      assert_equal 'http://example.com/someimage.jpg', parse(image('http://example.com/someimage.jpg'))[:src]
    end
    it 'defaults the source to an empty string' do
      assert_equal '', parse(image())[:src]
    end
    it 'puts nothing inside the image' do
      assert_equal '', parse(image('http://example.com/someimage.jpg')).text
    end
  end

  describe '#preserve_formatting' do
    it 'returns a pre tag' do
      assert_equal 'pre', parse(preserve_formatting()).name
    end
    it 'places the text within the pre tag' do
      assert_equal '  hi  ', parse(preserve_formatting('  hi  ')).text
    end
    it 'defaults the text to empty' do
      assert_equal '', parse(preserve_formatting()).text
    end
  end

  describe '#block' do
    it 'returns a div' do
      assert_equal 'div', parse(block()).name
    end
    it 'renders the text within the div' do
      assert_equal 'text, yo', parse(block('text, yo')).text
    end
    it 'defaults the text to empty' do
      assert_equal '', parse(block()).text
    end
    it 'accepts an array of classes that it adds to the div with spaces separating the elements' do
      assert_equal 'z abc xy', parse(block(classes: ['z', 'abc', 'xy']))[:class]
    end
    it 'does not add classes when none are provided' do
      assert_equal nil, parse(block())[:class]
    end
  end

  describe '#inline' do
    it 'returns a span' do
      assert_equal 'span', parse(inline()).name
    end
    it 'renders the text within the span' do
      assert_equal 'text, yo', parse(inline('text, yo')).text
    end
    it 'defaults the text to empty' do
      assert_equal '', parse(inline()).text
    end
    it 'accepts an array of classes that it adds to the source' do
      assert_equal 'z abc xy', parse(inline(classes: ['z', 'abc', 'xy']))[:class]
    end
    it 'does not add classes when it is not told to' do
      assert_equal nil, parse(inline())[:class]
    end
  end

  describe '#list' do
    it 'returns an ordered list when told to be ordered' do
      assert_equal 'ol', parse(list(ordered: true)).name
    end
    it 'returns an unordered list when told to not be ordered' do
      assert_equal 'ul', parse(list(ordered: false)).name
    end
    it 'returns an unordered list when not told whether it should be ordered' do
      assert_equal 'ul', parse(list()).name
    end
    it 'accepts a collection of items to place in li tags within the list' do
      l = parse(list(items: ['a', 'b', 'c']))
      assert_equal ['li', 'li', 'li'], l.children.map { |child| child.name }
      assert_equal ['a',  'b',  'c'],  l.children.map { |child| child.text }
    end
    it 'adds no items, by default' do
      assert_equal [], parse(list()).children.map(&:name)
    end
  end

  describe 'acceptance test' do
    it 'can create some reasonably useful html' do
      your_html = html title: 'Mah Websitez', body: (
        header('Here are some things', level: 1) +
        block(
          header('These ones I like!', level: 2) +
          list(items: ['brown', '12', 'independence', 'compassion', 'people cooking for me', 'music', 'honesty', 'whiskey', 'acceptance', 'ruby']),
          classes: ['lists', 'like', 'living-life-on-a-train']
        ) +
        block(
          header('The Ruby!', level: 2) +
          paragraph("This site was #{bold 'made with Ruby'} and also #{italics 'love'}!") +
          paragraph('Here is an example of Ruby!') +
          preserve_formatting('puts "Hello, world!"'),
          classes: ['examples', 'Ruby']
        ) +
        block(
          header('Here are some things I love!', level: 2) +
          list(ordered: true, items: ['me', 'you', 'other things, too']),
          classes: ['lists', 'love']
        ) +
        paragraph(
          'Thanks for stopping by, now its time to say goodbye' +
          italics('(a tear wells within my eye)')
        )
      )

      assert_html_equal <<-HTML, your_html
      <!doctype html>
      <html>
        <head><title>Mah Websitez</title></head>
        <body>
          <h1>Here are some things</h1>

          <div class="lists like living-life-on-a-train">
            <h2>These ones I like!</h2>
            <ul><li>brown</li>
                <li>12</li>
                <li>independence</li>
                <li>compassion</li>
                <li>people cooking for me</li>
                <li>music</li>
                <li>honesty</li>
                <li>whiskey</li>
                <li>acceptance</li>
                <li>ruby</li>
            </ul>
          </div>

          <div class="examples Ruby">
            <h2>The Ruby!</h2>
            <p>This site was <strong>made with Ruby</strong> and also <em>love</em>!</p>
            <p>Here is an example of Ruby!</p>
            <pre>puts "Hello, world!"</pre>
          </div class="">

          <div class="lists love">
            <h2>Here are some things I love!</h2>
            <ol><li>me</li>
                <li>you</li>
                <li>other things, too</li>
            </ol>
          </div>

          <p> Thanks for stopping by, now its time to say goodbye
              <em>(a tear wells within my eye)</em>
          </p>
        </body>
      </html>
      HTML
    end
  end
end
