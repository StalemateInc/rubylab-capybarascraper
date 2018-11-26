$LOAD_PATH.unshift(File.expand_path('lib', __dir__))

require 'capybara'
require 'csv_writer'
require 'onliner_parser'
require 'onliner_xpaths'

# webdriver configuration for Gecko
Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, browser: :firefox)
end

Capybara.javascript_driver = :firefox
Capybara.configure do |config|
  config.default_max_wait_time = 10
  config.default_driver = :selenium
end

PAGE_URL = 'https://www.onliner.by'.freeze

browser = Capybara.current_session
driver = browser.driver.browser
browser.visit PAGE_URL

onliner_parser = OnlinerMainNewsParser.new(PAGE_URL)
main_news = onliner_parser.parse(OnlinerXPaths::MAIN_NEWS_PATHS)
secondary_news = onliner_parser.parse(OnlinerXPaths::SECONDARY_PATHS)
list_news = onliner_parser.parse(OnlinerXPaths::LIST_PATHS)
teaser_news = onliner_parser.parse(OnlinerXPaths::TEASER_PATHS)
opinions_news = onliner_parser.parse(OnlinerXPaths::OPINIONS_PATHS)

all_news = main_news + secondary_news + list_news + teaser_news + opinions_news
writer = CSVWriter.new('./csv/', 'Onliner')
writer.write_chunk(all_news)