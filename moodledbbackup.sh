#!/usr/bin/env bash
######
# moodledbbackup.sh
# Compatibility wrapper for database-only Moodle backups.
# @author: Matt Gleeson <matt@mattgleeson.net>
# @license: GPL2
######

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"

exec "${SCRIPT_DIR}/moodle_autoback" --db-only "$@"
