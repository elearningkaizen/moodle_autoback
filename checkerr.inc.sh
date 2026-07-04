# shellcheck shell=bash disable=SC2034
###########################################################################################
## checkerr - check previous command status and provide shared output colouring.
##
## @author: Matt Gleeson <matt@mattgleeson.net>
## @description: for error checking of immediately previous command & output colouring
## @version: 20161115-20170605
## @usage: for output colouring eg.
##      echo -e "${err} error msg ${yellow}this will be yellow${rst} this will be normal"
##      echo -e "${warn} a warning ${red}this will be red${rst}"
##      echo -e "${ok} an OK message"
##      echo -e "${info} info message"
##      echo -e "${done} done message"
##
## for error checks for immediately previous executed commands, include the following
## after the command - more descriptive messages can be specified in place of $_ if needed:
##
## checkerr "$_" "$?"
##

red='\033[01;31m'
blue='\033[01;34m'
green='\033[01;32m'
yellow='\033[0;33m'
rst='\033[00m'

space="     "
margin="         "
err="[ ${red}ERROR${rst} ]${space}"
info="[ ${blue}INFO${rst} ] ${space}"
warn="[ ${yellow}WARN${rst} ] ${space}"
ok="[  ${green}OK${rst}  ] ${space}"
done="[ ${blue}DONE${rst} ] ${space}"


checkerr () {
    local prog="$1"
    local status="$2"
    local nonFatal="${3:-false}"

    if [[ "${status}" -eq 0 ]]; then
        echo -e "${ok} ${blue}${prog}${rst} ${green}success${rst}"
        return 0
    fi

    echo "" && echo ""
    echo -e "${err} execution of ${prog} ${red}failed${rst} with status: ${status}"
    echo "" && echo ""

    if [[ "${nonFatal}" == "true" ]]; then
        return "${status}"
    fi

    exit "${status}"
}

## set checkerr_loaded var to true to allow scripts or other includes that depend on it to check for it before running
checkerr_loaded="true"

if [[ "${CHECKERR_QUIET:-false}" != "true" ]]; then
    echo -e "${ok} checkerr loaded"
    echo
fi
##
## END CHECKERR
##############################################################################
