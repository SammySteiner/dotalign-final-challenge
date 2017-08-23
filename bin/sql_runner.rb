require_relative 'environment'

class SQLRunner
  def initialize(db)
    @db = db
  end

  def execute_create
    sql = File.read('lib/sql/create.sql')
    @db.execute_batch(sql)
  end

end
