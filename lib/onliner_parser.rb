require 'mechanize'
require 'parser_wireframe'

class OnlinerMainNewsParser < ParserWireframe

  ARTICLE_TITLE_XPATH = '//title/text()'.freeze
  ARTICLE_CONTENTS_XPATH = '//div[contains(@class, "news-text")]//p/text()'.freeze

  def initialize(url)
    super(url)
    @driver = Mechanize.new
    @saved = @driver.get(@url)
  end

  def parse(paths)
    @image_xpath, @link_xpath = *paths
    parse_info(@image_xpath, @link_xpath)
  end

  private

  def parse_info(image_path, link_path)
    document = @saved
    images = extract_background_image(document.xpath(image_path))
    links = document.xpath(link_path).map(&:value)
    combined = images.zip(links, [])
    combined.map! do |info|
      title, contents = extract(info[1])
      puts "Parsed: #{info[0]}, #{title}, #{contents}"
      [info[0], title, contents]
    end
    clean(combined)
  end

  def extract(url)
    article = @driver.get(url)
    title = article.xpath(ARTICLE_TITLE_XPATH).text.strip
    contents = article.xpath(ARTICLE_CONTENTS_XPATH).text[0...200]
    puts "Parsed: #{title}, #{contents}"
    [title, contents]
  end

  def extract_background_image(elements)
    elements.map do |style|
      image_string = style.value
      if image_string.start_with? 'background-image'
        image_string.match(/\((.+)\)/)[1]
      else
        image_string
      end
    end
  end

  def clean(combined)
    before_cleanup = combined.length
    combined = combined.reject \
      { |element| element[1].empty? || element[2].empty? }
    puts ''
    puts '#' * 10 + " Cleanup: deleted #{before_cleanup - combined.length} of bad news " + '#' * 20
    puts ''
    combined
  end
end