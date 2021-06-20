require 'csv'
require_relative 'transforms'

class CSVProcessor
  attr_reader :input_path, :output_path, :report_path, :output, :save

  def initialize(args, save=true)
    @input_path = args[0]
    @output_path = args[1] || 'output.csv'
    @report_path = args[2] || 'report.txt'
    @save = save
  end

  def process
    phone_converter = ->(val) { Transforms.phone_number(val) }
    date_converter = ->(val) { Transforms.date(val) }

    File.open(@input_path) do |input|
      CSV.foreach(input, headers: true, return_headers: true, strip: true,
                  header_converters: [:downcase, :symbol],
                  converters: [phone_converter, date_converter]) do |row|
        puts row
      end
    end
  end
end
