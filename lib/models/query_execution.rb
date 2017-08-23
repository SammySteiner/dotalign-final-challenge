require_relative '../../bin/environment.rb'

class QueryExecution

  attr_accessor :execution_date_time, :execution_speed, :database_type, :database_file_name, :query_name_id
  @@db = SQLite3::Database.open('db/Data.db')

  def initialize execution_date_time, execution_speed, database_type, database_file_name, query_name_id
    @execution_date_time = execution_date_time
    @execution_speed = execution_speed
    @database_type = database_type
    @database_file_name = database_file_name
    @query_name_id = query_name_id
    save
  end

  def save
    query = "INSERT INTO query_execution (execution_date_time, execution_speed, database_type, database_file_name, query_name_id) VALUES ('#{@execution_date_time}', #{@execution_speed}, '#{@database_type}', '#{@database_file_name}', #{@query_name_id});"
    @@db.execute(query)
  end

end
