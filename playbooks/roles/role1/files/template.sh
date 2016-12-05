#!/bin/bash

#SCRIPT_NAME=$(echo $0 | grep -E -o "[^/]+$")
SCRIPT_NAME="$(basename "$0")"
WKDIR="$(dirname "$0")"
ARG1=$1
ARG2=$2
ARG3=$3

# USAGE
usage() {
  echo
  echo -e "\E[37;1;42m${SCRIPT_NAME}\033[0m -- what this script does."
  echo -n "Usage: "
  echo "${SCRIPT_NAME} <ARG1> [ARG2] [ARG3]"
  echo
}

########## START COMMON FUNCTIONALITY #########################################

# COMMON MESSAGE TEMPLATES.
ERROR="$SCRIPT_NAME: \E[37;1;41mERROR:\033[0m"
WARNING="$SCRIPT_NAME: \E[30;43mWARNING:\033[0m"
INFO="$SCRIPT_NAME: \E[37;1;44mINFO:\033[0m"
RESULTS="$SCRIPT_NAME: \E[37;1;45mRESULTS:\033[0m"
GOODBYE="$SCRIPT_NAME: \E[34;47mGoodbye!\033[0m"
ALLDONEBYE="$SCRIPT_NAME: \E[34;47mAll done--bye now!\033[0m"

# SAYS GOODBYE.
sayGoodbye() {
  #cleanUpAndLogout
  echo
  echo -e "$GOODBYE"
  exit
}

# SAYS ALL DONE--BYE NOW.
sayAllDoneBye() {
  #cleanUpAndLogout
  echo
  echo -e "$ALLDONEBYE"
  exit
}

# CONFIRMS IF SHOULD PROCEED--DEFAULT IS YES (y).
confirmProceedDefaultYes() {
  read -e PROCEED
  # IF USER ENTERED SOMETHING, THEN IT MUST BE A YES-LIKE INDICATION; HOWEVER, ENTERING NOTHING IMPLIES YES (DEFAULT).
  if [ -n "$PROCEED" ]; then
    if [ "$PROCEED" != "y" ] && [ "$PROCEED" != "yes" ] && [ "$PROCEED" != "Y" ] && [ "$PROCEED" != "Yes" ] && [ "$PROCEED" != "YES" ]; then
      sayGoodbye
    fi
  fi
}

# CONFIRMS IF SHOULD PROCEED--DEFAULT IS NO (n).
confirmProceedDefaultNo() {
  read -e PROCEED
  # IF USER ENTERED SOMETHING, THEN IT MUST BE A YES-LIKE INDICATION TO PROCEED.
  if [ -n "$PROCEED" ]; then
    if [ "$PROCEED" != "y" ] && [ "$PROCEED" != "yes" ] && [ "$PROCEED" != "Y" ] && [ "$PROCEED" != "Yes" ] && [ "$PROCEED" != "YES" ]; then
      echo
      #cleanupAndLogout
      sayGoodbye
    fi
  # ELSE, IF USER ENTERED NOTHING, EXIT.
  else
    echo
    #cleanupAndLogout
    sayGoodbye
  fi
}

# TESTS COMMON FUNCTIONALITY.

doCommonTest() {
  usage
  echo -e "$ERROR"
  echo -e "$WARNING"
  echo -e "$INFO"
  echo -e "$RESULTS"
  echo -e "$GOODBYE"
  echo -e "$ALLDONEBYE"
  echo -n "Default Yes [y]:"; confirmProceedDefaultYes
  echo -n "Default No [n]:"; confirmProceedDefaultNo
}
########## END COMMON FUNCTIONALITY #########################################

# UNCOMMENT NEXT LINE TO TEST COMMON FUNCTIONALITY.
doCommonTest
