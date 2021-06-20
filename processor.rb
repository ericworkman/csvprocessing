require 'pathname'
require_relative 'lib/csvprocessor'

def help_message
  <<~HEREDOC

  Process a csv of patient records and export a file of cleaned and validated records and a summary report.
  Output files will automatically overwrite output from previous runs.

  Usage:
    ruby processor.rb file [output] [report]

  HEREDOC
end

if ARGV.length > 0 && Pathname.new(ARGV[0]).exist?
  CSVProcessor.new(ARGV).process
else
  puts help_message
  exit 1
end
