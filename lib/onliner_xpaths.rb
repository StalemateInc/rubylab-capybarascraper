module OnlinerXPaths
  TEASER_PATH = '//div[contains(@class, "g-middle-i")]//ul[contains(@class, "b-teasers-2")]//a[contains(@class, "teasers-2__teaser-i")]'.freeze
  TEASER_IMAGE = (TEASER_PATH + '/@data-style').freeze
  TEASER_LINK = (TEASER_PATH + '/@href').freeze

  MAIN_NEWS_PATH = '//section[contains(@class, "b-main-page-news-2__main-news")]'.freeze
  MAIN_NEWS_IMAGE = (MAIN_NEWS_PATH + '//figure//img[contains(@class, "b-section-main__col-fig")]/@data-src').freeze
  MAIN_NEWS_LINK = (MAIN_NEWS_PATH + '//article//div[contains(@class, "b-main-page-news-2__main-news-title")]//h2//a/@href').freeze

  SECONDARY_PATH = '//section[contains(@class, "b-main-page-news-2__secondary-news")]//article'.freeze
  SECONDARY_IMAGE = (SECONDARY_PATH + '/figure/a/img/@data-src').freeze
  SECONDARY_LINK = (SECONDARY_PATH + '/h2/a/@href').freeze

  LIST_PATH = '//ul[contains(@class, "b-main-page-news-2__news-list")]/li'.freeze
  LIST_IMAGE = (LIST_PATH + '/figure/a/img/@data-src').freeze
  LIST_LINK = (LIST_PATH + '/figure/a/@href').freeze

  OPINIONS_PATH = '//ul[contains(@class, "b-opinions-main-2")]/li'.freeze
  OPINIONS_IMAGE = (OPINIONS_PATH + '/div/@data-style').freeze
  OPINIONS_LINK = (OPINIONS_PATH + '/div/a[position() = 1]/@href').freeze
end