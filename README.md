### Homework 03 "First testing task. Scraping with Capybara"  
**Scrape main news from Onliner.by using Capybara**  
Task:
* Create a repository
* Add a gemfile, install Capybara, Selenuim (+ Gecko webdriver in my case ,'cause I use Fifefox)
* Create "lib" directory and place the source code there for parser and csv-writer
* Configure Capybara agent
* Visit onliner.by with Capybara, get all the news from the main page
* Save news in a .csv file in a [image_url, title, first 200 chars from the article] format

---
## Notes:
1) I've tried to scrape with Capybara itself, but in 90% of cases every valid css or xpath selector was timed-out and then the exception was raised. I don't why it kept happening, so I switched to Nokogiri, and later, to Mechanize to speed up the process.
2) Nokogiri part from earlier commits dropped and replaced with more efficient and fast Mechanize code
3) `OnlinerMainNewsParser` parses not only *main* news, but also news from teasers, articles from "opinions" block, secondary and listed in a columns news from the main page. This is by design and be turned off.
4) Mechanized connects to other pages to get better title and first 200 characters from the article, because sometimes no text provided for the news itself on the main page.
5) App is still opening the page with Capybara to prove it is working.
