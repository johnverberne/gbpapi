clear_log

default_database_name ($database_name_prefix + '-' + $current_module.to_s + '-dumpsql')

start_sql_recorder "structure-#{get_database_name()}.sql"
  create_database :overwrite_existing
  import_database_structure
  update_comments
stop_sql_recorder

start_sql_recorder "data-#{get_database_name()}.sql"
  load_data
  analyze_vacuum_database :analyze
stop_sql_recorder
