# moodle_autoback

![moodle_autoback logo](logo_sml.png)

`moodle_autoback` backs up a Moodle site's database, webroot files, and
`moodledata` directory from one command. It reads the required database and data
directory settings from Moodle's `config.php`.

The old `moodledbbackup.sh` and `moodlefilesbackup.sh` scripts are still present
for now. New work should use `moodle_autoback`.

## Usage

```bash
./moodle_autoback /path/to/moodle
./moodle_autoback ./moodle
./moodle_autoback --moodlepath /path/to/moodle
./moodle_autoback -m /path/to/moodle
```

By default, the script backs up:

* the Moodle database
* the Moodle webroot
* the Moodle `dataroot`

## Backup Location

If `--backup-path` is not supplied, the script looks beside the Moodle webroot
for a backup directory:

1. `backups/`
2. `backup/`

For example, if the Moodle webroot is:

```bash
/var/www/mymoodle.com.au/public_html
```

then the script checks:

```bash
/var/www/mymoodle.com.au/backups
/var/www/mymoodle.com.au/backup
```

If neither directory exists, backups are written to the current working
directory. The script refuses to run from inside the Moodle webroot and refuses
to write backup output inside the Moodle webroot.

## Options

```bash
./moodle_autoback /path/to/moodle --backup-path /path/to/backups
./moodle_autoback /path/to/moodle -b /path/to/backups
./moodle_autoback /path/to/moodle --db-only
./moodle_autoback /path/to/moodle --files-only
./moodle_autoback /path/to/moodle --data-only
./moodle_autoback /path/to/moodle --single-archive
./moodle_autoback /path/to/moodle --bundle
./moodle_autoback /path/to/moodle --dry-run
./moodle_autoback /path/to/moodle --debug
./moodle_autoback /path/to/moodle --email someone@example.com
./moodle_autoback --version
./moodle_autoback --help
```

`--single-archive` and `--bundle` create one final `.tar.gz` containing the
selected backup archives.

Multiple `--*-only` options can be combined. For example:

```bash
./moodle_autoback /path/to/moodle --db-only --data-only
```

## Preflight Checks

Before writing backups, the script checks:

* the Moodle path exists
* `config.php` is readable
* the backup path exists and is writable
* the current directory is not inside the Moodle webroot
* the backup path is not inside the Moodle webroot
* required commands are available
* database access works when a database backup is selected
* `moodledata` is readable when a data backup is selected
* selected file trees can be traversed before archive writing starts

Required commands for a full backup:

* `bash`
* `find`
* `mysql`
* `mysqldump`
* `tar`
* `gzip`

If `--email` is used, either `mutt` or `sendmail` is required. The `sendmail`
path also requires `base64` for attachments.

## Output Files

The database backup is written as:

```bash
SITE_DB_DBNAME_backup_YYYY-MM-DD--HHMMSS.sql.gz
```

The webroot backup is written as:

```bash
SITE_files_backup_YYYY-MM-DD--HHMMSS.tar.gz
```

The Moodle data backup is written as:

```bash
SITE_moodledata_backup_YYYY-MM-DD--HHMMSS.tar.gz
```

When `--single-archive` is used, the final archive is:

```bash
SITE_full_backup_YYYY-MM-DD--HHMMSS.tar.gz
```

## Notes

The `moodledata` backup excludes:

* `cache`
* `temp`
* `trashdir`

The site name used in filenames comes from Moodle's course shortname where
`sortorder = 1`. If that query fails, the database name is used instead.
