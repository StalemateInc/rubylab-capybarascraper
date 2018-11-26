class ParserWireframe
  attr_reader :driver
  attr_accessor :url, :document

  def initialize(url, driver)
    @url = url
    @driver = driver
  end

  def parse; end
  def extract; end
  def clean; end
end


