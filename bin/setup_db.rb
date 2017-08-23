require_relative 'environment'

db = SQLite3::Database.new('db/Data.db')
sql_runner = SQLRunner.new(db)

sql_runner.execute_create
