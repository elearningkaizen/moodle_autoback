#!/usr/bin/env bash
######
# moodlefilesbackup.sh
# Compatibility wrapper for Moodle webroot and moodledata backups.
# @author: Matt Gleeson <matt@mattgleeson.net>
# @license: GPL2
######

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"

exec "${SCRIPT_DIR}/moodle_autoback" --files-only --data-only "$@"
