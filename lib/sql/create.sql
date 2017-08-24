CREATE TABLE query_name (
  id INTEGER PRIMARY KEY,
  query_name TEXT
);

CREATE TABLE query_execution (
  id INTEGER PRIMARY KEY,
  execution_date_time TEXT,
  execution_speed REAL,
  database_type TEXT,
  database_file_name TEXT,
  query_name_id INTEGER
);
