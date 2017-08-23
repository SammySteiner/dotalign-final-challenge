require 'date'

class LogParser

  attr_reader :path

  def initialize path
    @log = File.open( path )
  end

  def valid_line?(line)
    line.include?('entity type')
  end

  def parse_log
    @log.each_line do |line|
      if valid_line?(line)
        parsed_line = line.gsub(/\s+/, ' ').split(' | ')
        execution_date_time = parsed_line[0].gsub("/","-")
        execution_speed = parsed_line[4].chomp(' ms:').to_f
        databas_type = parsed_line[5]
        database_file_name = parsed_line[6]
        name = parsed_line[7].split.last

        query_name = QueryName.find_or_create_by(name)
        query_name_id = query_name.id

        QueryExecution.new(execution_date_time, execution_speed, databas_type, database_file_name, query_name_id)
      end
    end
  end



end
