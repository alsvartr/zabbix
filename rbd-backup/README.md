## rbd-backup

Backup status metrics for rbd-backup utility from [atceph](https://github.com/alsvartr/atceph/)

* UserParameters
  * rbd-backup.export_errors: error count during export volumes

  * rbd-backup.archive_errors: error count during archive volumes

  * rbd-backup.last: minutes since last backup proccess

  * rbd-backup.duration: duration of last backup proccess

<br>

* scripts
  * rbd-backup-status.rb

<br>

* templates
  * template_rbd-backup.xml

## Dependencies

* ruby

* ruby-json
