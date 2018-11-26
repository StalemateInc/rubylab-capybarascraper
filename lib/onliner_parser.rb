require 'nokogiri'
require 'parser_wireframe'

class OnlinerMainNewsParser < ParserWireframe

  ARTICLE_TITLE_XPATH = '//title/text()'.freeze
  ARTICLE_CONTENTS_XPATH = '//div[contains(@class, "news-text")]//p/text()'.freeze

  def initialize(url, driver)
    super(url, driver)
    @saved = Nokogiri::HTML(@driver.body)
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
      [info[0], title, contents]
    end
    clean(combined)
  end

  def extract(url)
    @driver.visit url
    article = Nokogiri::HTML(@driver.body)
    title = article.xpath(ARTICLE_TITLE_XPATH).text.strip
    contents = article.xpath(ARTICLE_CONTENTS_XPATH).text[0...200]
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
    combined = combined.reject \
      { |element| element[1].empty? || element[2].empty? }
    combined
  end
end