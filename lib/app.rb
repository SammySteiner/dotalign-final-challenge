require_relative './models/log_parser.rb'
require_relative './models/query_execution.rb'
require_relative './models/query_name.rb'

require 'pry'

def run_sql_query
  db = SQLite3::Database.open('db/Data.db')
  query = "
  SELECT query_name.query_name, AVG(query_execution.execution_speed)  FROM query_name
  JOIN query_execution ON query_name.id == query_execution.query_name_id
  GROUP BY query_name.query_name
  ORDER BY AVG(query_execution.execution_speed) DESC
  ;"
  results = db.execute(query)
end

def format_results(unformatted_results)
  results = run_sql_query
  query_names = results.map { |r| r[0] }
  longest = query_names.max_by(&:length).length
  space = ' '
  puts "Query Name #{space * (longest - 10)}| Average Speed"
  puts "---------------------#{'-' * longest}"
  results.each do |r|
    puts "#{r[0]}#{space * (longest - r[0].length)} | #{r[1].to_s}"
  end
end

def help
  help = <<-HELP
I accept the following commands:
- help : displays this help message
- 1    : accepts a file path and returns a report
- exit : exits this program
HELP

  puts help
end

def exit_log_parser
  puts "Goodbye"
end

def avg_speed
  puts "Enter the path for the log file you'd like to evaluate"
  file = gets.chomp
  log_file = LogParser.new(file)
  log_file.parse_log
  unformatted_results = run_sql_query
  format_results(unformatted_results)
end

def runner
  input = ""
  while input
    help
    input = gets.chomp
    case input
    when 'help'
    when '1'
      avg_speed
    when 'exit'
      exit_log_parser
      break
    else
      help
    end
  end
end
