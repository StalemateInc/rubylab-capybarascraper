module OnlinerXPaths
  TEASER_BASE = '//div[contains(@class, "g-middle-i")]//ul[contains(@class, "b-teasers-2")]//a[contains(@class, "teasers-2__teaser-i")]'.freeze
  TEASER_IMAGE = (TEASER_BASE + '/@data-style').freeze
  TEASER_LINK = (TEASER_BASE + '/@href').freeze
  TEASER_PATHS = [TEASER_IMAGE, TEASER_LINK].freeze

  MAIN_NEWS_BASE = '//section[contains(@class, "b-main-page-news-2__main-news")]'.freeze
  MAIN_NEWS_IMAGE = (MAIN_NEWS_BASE + '//figure//img[contains(@class, "b-section-main__col-fig")]/@data-src').freeze
  MAIN_NEWS_LINK = (MAIN_NEWS_BASE + '//article//div[contains(@class, "b-main-page-news-2__main-news-title")]//h2//a/@href').freeze
  MAIN_NEWS_PATHS = [MAIN_NEWS_IMAGE, MAIN_NEWS_LINK].freeze

  SECONDARY_BASE = '//section[contains(@class, "b-main-page-news-2__secondary-news")]//article'.freeze
  SECONDARY_IMAGE = (SECONDARY_BASE + '/figure/a/img/@data-src').freeze
  SECONDARY_LINK = (SECONDARY_BASE + '/h2/a/@href').freeze
  SECONDARY_PATHS = [SECONDARY_IMAGE, SECONDARY_LINK].freeze

  LIST_BASE = '//ul[contains(@class, "b-main-page-news-2__news-list")]/li'.freeze
  LIST_IMAGE = (LIST_BASE + '/figure/a/img/@data-src').freeze
  LIST_LINK = (LIST_BASE + '/figure/a/@href').freeze
  LIST_PATHS = [LIST_IMAGE, LIST_LINK].freeze

  OPINIONS_BASE = '//ul[contains(@class, "b-opinions-main-2")]/li'.freeze
  OPINIONS_IMAGE = (OPINIONS_BASE + '/div/@data-style').freeze
  OPINIONS_LINK = (OPINIONS_BASE + '/div/a[position() = 1]/@href').freeze
  OPINIONS_PATHS = [OPINIONS_IMAGE, OPINIONS_LINK].freeze
end