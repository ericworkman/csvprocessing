class CSVProcessor
  attr_reader :input_path, :output_path, :report_path, :output, :save

  def initialize(args, save=true)
    @input_path = args[0]
    @output_path = args[1] || 'output.csv'
    @report_path = args[2] || 'report.txt'
    @save = save
  end

  def process
  end
end
