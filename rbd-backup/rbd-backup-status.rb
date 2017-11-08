#!/usr/bin/ruby
require "json"

begin
      stat = JSON.parse( File.read("/tmp/rbd-backup-stat") )
      stat = stat["total"]
rescue
      exit 1
end

param = ARGV[0]

case param
when "export_errors"
      puts stat["export_errors"]
when "archive_errors"
      puts stat["archive_errors"]
when "backup_last"
      now = Time.now.to_i
      diff_mins = (now - stat["archive_end"].to_i) / 60
      puts diff_mins
when "backup_duration"
      dur_mins = (stat["archive_end"] - stat["export_start"]) / 60
      puts dur_mins
else
      puts "ZBX_NOTSUPPORTED"
end
