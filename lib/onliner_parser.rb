require 'nokogiri'
require 'capybara'
require 'parser_wireframe'
require 'onliner_xpaths'

class OnlinerMainNewsParser < ParserWireframe
  include OnlinerXPaths

  def initialize(url, driver)
    super(url, driver)
    @saved = Nokogiri::HTML(@driver.body)
  end

  def parse
    main = parse_info(OnlinerXPaths::MAIN_NEWS_IMAGE, OnlinerXPaths::MAIN_NEWS_LINK)
    secondary = parse_info(OnlinerXPaths::SECONDARY_IMAGE, OnlinerXPaths::SECONDARY_LINK)
    list_news = parse_info(OnlinerXPaths::LIST_IMAGE, OnlinerXPaths::LIST_LINK)
    opinions = parse_info(OnlinerXPaths::OPINIONS_IMAGE, OnlinerXPaths::OPINIONS_LINK)
    teasers = parse_info(OnlinerXPaths::TEASER_IMAGE, OnlinerXPaths::TEASER_LINK)
    main + secondary + list_news + opinions + teasers
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
    title = article.xpath('//title/text()').text.strip
    contents = article.xpath('//div[contains(@class, "news-text")]//p/text()').text[0...200]
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
    combined = combined.reject { |element| element[1].empty? || element[2].empty? }
    combined
  end
end