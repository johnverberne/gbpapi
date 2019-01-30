#
# Application specific settings. Define override values in AeriusSettings.User.rb (same location).
#

$runscripts_path = File.expand_path(File.dirname(__FILE__) + '/../scripts/').fix_pathname


$git_bin_path = '' # Git bin folder should be in PATH


$pg_username = ''
$pg_password = '...'


$dbdata_dir = 'db-data/nca/'
$dbdata_path = File.expand_path(File.dirname(__FILE__) + '/../../../' + $dbdata_dir).fix_pathname


$database_name_prefix = 'NCA'

$db_function_prefix = 'ae'


$sftp_data_path = ''

$sftp_data_readonly_username = ''
$sftp_data_readonly_password = '...' # Override in NcaSettings.User.rb

$sftp_data_username = '' # Please Leave this blank and do not use two way sync
$sftp_data_password = '' # Please Leave this blank and do not use two way sync