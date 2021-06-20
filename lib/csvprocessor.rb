require 'csv'
require 'date'
require_relative 'transforms'
require_relative 'validators'

class CSVProcessor
  # Relative path for a csv file to process
  attr_reader :input_path
  # Relative path of a csv and txt file for cleaned output and stats
  attr_reader :output_path, :report_path
  # Flag to produce output and stats files
  attr_reader :save
  # Cleaned and validated records
  attr_reader :output
  # Stats
  attr_reader :records, :valid_records, :invalid_rows, :start, :stop, :elapsed

  def initialize(args, save=true)
    @input_path = args[0] || ''
    @output_path = args[1] || 'output.csv'
    @report_path = args[2] || 'report.txt'
    @save = save
    @output = []
    @records = 0
    @valid_records = 0
    @invalid_rows = []
    @start = Time.now()
  end

  def process
    phone_converter = ->(val) { Transforms.phone_number(val) }
    date_converter = ->(val) { Transforms.date(val) }

    File.open(@input_path) do |input|
      CSV.open(input, headers: true, return_headers: true, strip: true,
               header_converters: [:downcase, :symbol],
               converters: [phone_converter, date_converter]) do |csv|
                 @output << csv.shift.to_csv
                 csv.each do |row|
                   @records += 1
                   valid = Validators.exists?(row[:first_name]) &&
                    Validators.exists?(row[:last_name]) &&
                    Validators.date?(row[:dob]) &&
                    Validators.exists?(row[:member_id]) &&
                    Validators.date?(row[:effective_date]) &&
                    Validators.phone_number?(row[:phone_number])
                   if valid
                     @valid_records += 1
                     @output << row.to_csv
                   else
                     @invalid_rows << csv.lineno
                   end
                 end
      end
    end

    @stop = Time.now()
    @elapsed = @stop.to_i - @start.to_i

    if @save
      save_output()
      save_report()
    end

  end

  private

  def save_output
    File.open(@output_path, 'w') do |file|
      file.puts(@output)
    end
  end

  def save_report
    File.open(@report_path, 'w') do |file|
      file.puts("File: #{@input_path}, \
        Output: #{@output_path}, \
        Started: #{@start}, \
        Ended: #{@stop}, \
        Elapsed: #{@elapsed} seconds, \
        Records: #{@records}, \
        Valid Records: #{@valid_records}, \
        Issues: lines #{@invalid_rows}")
    end
  end
end
