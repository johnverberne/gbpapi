clear_log

check_datasources

if has_build_flag :release_candidate then
  puts "#{'*' * 20} RELEASE CANDIDATE #{'*' * 20}"
  create_database # error if exists!
else
  create_database :overwrite_existing
end

begin

  import_database_structure
  update_comments

  load_data

  generate_html_documentation
  generate_rtf_documentation

  if has_build_flag :quick then
    analyze_vacuum_database :analyze
  else
    analyze_vacuum_database :vacuum, :analyze
  end

  # The following flags can be set to true by the load.rb, but for performance reasons we want to execute them *after* the vacuum/analyze.
  run_unit_tests if $do_run_unit_tests
  validate_contents if $do_validate_contents
  create_summary if $do_create_summary

  dump_database :overwrite_existing unless has_build_flag :quick

  # (Temporary) special build flags: drop setup schema and dump again. This is a 'lighter' version of the database, used for monitor.
  if ($product == :monitor) && (has_any_build_flag :delete_setup_schema, :delete_setup_schema_and_redump) then
    execute_sql 'DROP SCHEMA setup CASCADE'

    if has_build_flag :delete_setup_schema_and_redump then
      org_dump_filetitle = $dump_filetitle
      $dump_filetitle = $database_name + '.nosetup.backup'
      dump_database :overwrite_existing
      $dump_filetitle = org_dump_filetitle
    end
  end

ensure

  drop_database_if_exists :aggressive if $on_build_server

end
