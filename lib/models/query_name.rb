require_relative '../../bin/environment.rb'

class QueryName

  attr_accessor :name, :id

  @@all = []
  @@db = SQLite3::Database.open('db/Data.db')

  def initialize(name)
    @name = name
    @@all << self
    @id = @@all.count
    save
  end

  def save
    query = "INSERT INTO query_name (query_name) VALUES ('#{@name}');"
    @@db.execute(query)
  end

  def self.find_by(name)
    @@all.detect{|qn| qn.name == name}
  end

  def self.find_or_create_by(name)
    if QueryName.find_by(name)
      QueryName.find_by(name)
    else
      QueryName.new(name)
    end
  end



end
