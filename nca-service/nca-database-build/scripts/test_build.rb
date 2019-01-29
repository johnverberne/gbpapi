clear_log
default_database_name "test_structure"
check_datasources
create_database :overwrite_existing
begin
  import_database_structure
  update_comments
  generate_html_documentation
ensure
  drop_database_if_exists :aggressive if $on_build_server
end
