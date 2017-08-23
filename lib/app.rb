require_relative './models/log_parser.rb'
require_relative './models/query_execution.rb'
require_relative './models/query_name.rb'

require 'pry'

def run_sql_query
  db = SQLite3::Database.open('db/Data.db')
  results = db.execute("
  SELECT query_name.query_name, AVG(query_execution.execution_speed)  FROM query_name
  JOIN query_execution ON query_name.id == query_execution.query_name_id
  GROUP BY query_name.query_name
  ORDER BY AVG(query_execution.execution_speed) DESC
  ;
  ")
end

def format_results(unformatted_results)
  results = run_sql_query
  puts 'Query Name      |   Average Speed'
  puts "---------------------------------"
  results.each do |r|
    puts r[0] + ' | ' + r[1].to_s
  end
end

def runner
  puts "Enter the path for the log file you'd like to evaluate"
  input = gets.chomp
  log_file = LogParser.new(input)
  log_file.parse_log
  unformatted_results = run_sql_query
  format_results(unformatted_results)
end
