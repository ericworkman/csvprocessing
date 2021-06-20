require_relative '../../lib/csvprocessor'

RSpec.describe CSVProcessor do
  # Mocking out ARGV in these tests
  # Not testing that the help message is displayed, but I think I could capture the stdout.
  let(:input) { File.join(File.expand_path('../', __FILE__), 'test_input.csv') }
  let(:output) { 'different_output.csv' }
  let(:report) { 'different_report.txt' }

  context "with an input file" do
    let(:args) { [input] }
    it "would process the input file" do
      processor = CSVProcessor.new(args)
      expect(processor.input_path).to eq input
    end

    it "processes the data" do
      processor = CSVProcessor.new(args, false)
      processor.process()
      #expect(processor.output).to be_truthy
    end
  end

  context "with input and output files" do
    let(:args) { [input, output] }
    it "outputs to the correct file" do
      processor = CSVProcessor.new(args)
      expect(processor.output_path).to eq output
    end
  end

  context "with input, output, and report files" do
    let(:args) { [input, output, report] }
    it "reports to the correct file" do
      processor = CSVProcessor.new(args)
      expect(processor.report_path).to eq report
    end
  end

  context "without an input file" do
    let(:args) { [] }
    it "would not process the file" do
      processor = CSVProcessor.new(args)
    end
  end
end
