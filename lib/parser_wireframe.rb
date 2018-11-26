class ParserWireframe
  attr_reader :driver
  attr_accessor :url

  def initialize(url)
    @url = url
  end

  def parse; end
  def extract; end
  def clean; end
end


