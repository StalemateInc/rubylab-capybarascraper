require 'csv'

class CSVWriter
  attr_accessor :path, :prefix
  def initialize(path, file_prefix = 'New')
    @path = path
    @prefix = file_prefix
  end

  def write_chunk(data)
    CSV.open("#{@path}#{@prefix}#{Time.now}.csv", 'w') do |csv|
      data.each { |row| csv << row }
    end
  end
end