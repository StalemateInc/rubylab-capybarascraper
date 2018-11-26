$LOAD_PATH.unshift(File.expand_path('lib', __dir__))

require 'nokogiri'
require 'capybara'
require 'csv'
require 'onliner_parser'

def write_csv(data, file_prefix = 'Scrapped')
  CSV.open("./csv/#{file_prefix}#{Time.now}.csv", 'w') do |csv|
    data.each { |row| csv << row }
  end
end

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

main_news_parser = OnlinerMainNewsParser.new(PAGE_URL, browser)
main_news = main_news_parser.parse
write_csv(main_news, 'Onliner')
