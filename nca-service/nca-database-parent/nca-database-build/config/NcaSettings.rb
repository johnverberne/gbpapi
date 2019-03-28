#
# Application specific settings. Define override values in AeriusSettings.User.rb (same location).
#

$runscripts_path = File.expand_path(File.dirname(__FILE__) + '/../scripts/').fix_pathname


$git_bin_path = '' # Git bin folder should be in PATH


$pg_username = 'aerius'
$pg_password = '...'


$dbdata_dir = '/home/verberne/GroeneBatenPlanner-data'
$dbdata_path = File.expand_path(File.dirname(__FILE__) + '/../../../' + $dbdata_dir).fix_pathname


$database_name_prefix = 'NCA'

$db_function_prefix = 'ae'


$sftp_data_path = 'sftp://verberne.clouddiskspace.nl'

$sftp_data_readonly_username = 'verberne'
$sftp_data_readonly_password = '...' # Override in NcaSettings.User.rb

$sftp_data_username = '' # Please Leave this blank and do not use two way sync
$sftp_data_password = '' # Please Leave this blank and do not use two way sync