#!/bin/bash

#SCRIPT_NAME=$(echo $0 | grep -E -o "[^/]+$")
SCRIPT_NAME="$(basename "$0")"
WKDIR="$(dirname "$0")"
APP_NAME=$1
PLAYBOOK_NAME=$2
ROLE_NAME=$3

# USAGE
usage() {
  echo
  echo -e "\E[37;1;42m${SCRIPT_NAME}\033[0m -- configures a Playbook."
  echo -n "Usage: "
  echo "${SCRIPT_NAME} <APP_NAME> <PLAYBOOK_NAME> <ROLE_NAME>"
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
# doCommonTest

verifyVariablesNotEmpty() {
  declare -A VARS=(
    [APP_NAME]="$APP_NAME"
    [PLAYBOOK_NAME]="$PLAYBOOK_NAME"
    [ROLE_NAME]="$ROLE_NAME"
  )
  for i in ${!VARS[@]}; do
    # echo "[$i]:${VARS[$i]}"
    if [ -z "${VARS[$i]}" ]; then
      echo -e "$ERROR $i is missing a value"
      usage
      exit 1
    fi
  done
}

verifyVariablesNotEmpty

APP_NAME_LOWER=`echo "$APP_NAME" | tr '[:upper:]' '[:lower:]'`
APP_NAME_UPPER=`echo "$APP_NAME" | tr '[:lower:]' '[:upper:]'`

for i in `find . -type f`; do
  if [ "${i}" == "./$SCRIPT_NAME" ]; then
    echo "Found myself ($SCRIPT_NAME)...continuing..."
    continue
  fi
  grep "@@APP_NAME" $i
  if [ "$?" -eq "0" ]; then
    cp -fv $i ${i}.BAK
    sed -i "s/@@APP_NAME/$APP_NAME_LOWER/g" $i
  fi
  if [ "${i}" == "./playbook1.sh" ]; then
    cp -fv ${i} `echo ${i} | sed "s/playbook1\.sh/$PLAYBOOK_NAME\.sh/"`
    grep "playbook1" $PLAYBOOK_NAME.sh
    if [ "$?" -eq "0" ]; then
      sed -i "s/playbook1/$PLAYBOOK_NAME/g" $PLAYBOOK_NAME.sh
    fi
  fi
  if [ "${i}" == "./playbook1.yml" ]; then
    cp -fv ${i} `echo ${i} | sed "s/playbook1\.yml/$PLAYBOOK_NAME\.yml/"`
    grep "role1" $PLAYBOOK_NAME.yml
    if [ "$?" -eq "0" ]; then
      sed -i "s/role1/${ROLE_NAME}/g" $PLAYBOOK_NAME.yml
    fi
  fi
done

if [ -d roles/role1 ]; then
  cp -fvr roles/role1 roles/$ROLE_NAME
fi
