#!/usr/bin/env bash

set -e

#######################################
##### function to exit the script #####
#######################################
function exitScript()
{
    local message=$1
    [ -z "$message" ] && message="Died"
    echo -e "${RED}[${FAILED}] $message at ${BASH_SOURCE[1]}:${FUNCNAME[1]} line ${BASH_LINENO[0]}. ${RESET}" >&2
    exit 1
}

##################################
##### function to run action #####
##################################
function linting()
{
   [ -n "${ACTIONS_DIRECTORY}" ] && cd "${ACTIONS_DIRECTORY}"
   [ ! -z "${INPUT_FILES}" ] && filesToScan=$(echo ${INPUT_FILES} | tr -s ' ')

   if [ -z "${INPUT_ARGUMENTS}" ]; then
      COMMAND="actionlint ${filesToScan}"
   else
      COMMAND="actionlint ${INPUT_ARGUMENTS} ${filesToScan}"
   fi
   ${OPERATION} || exitScript "GitHub action linting is failing, exiting..."
   echo -e "${GREEN}[${SUCCESS}] Action Linting Passed!!! ${RESET}"
}

RED='\033[0;31m'
RESET='\033[0m'
CYAN='\033[0;36m'
GREEN='\033[0;32m'
SUCCESS='\u2714'
FAILED='\u274c'

linting
