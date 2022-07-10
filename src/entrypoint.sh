#!/usr/bin/env bash

set -e

OAUTH_TOKEN="${GMVAULT_DIR}/${GMVAULT_EMAIL_ADDRESS}.oauth2"

if [ $# = 0 ]; then
  if [ -f ${OAUTH_TOKEN} ]; then
    echo "Using OAuth token at ${OAUTH_TOKEN}"

    if [ -d ${GMVAULT_DIR}/db ]; then
      echo "Start ${GMVAULT_SYNC_TYPE} sync of ${GMVAULT_EMAIL_ADDRESS}"

      gmvault sync \
        --db-dir ${GMVAULT_DIR} \
        --type ${GMVAULT_SYNC_TYPE} \
        ${GMVAULT_OPTIONS} ${GMVAULT_EMAIL_ADDRESS} 2>&1 \
        | tee -a ${GMVAULT_DIR}/gmvault_${GMVAULT_SYNC_TYPE}.log

      echo "Completed ${GMVAULT_SYNC_TYPE} sync of ${GMVAULT_EMAIL_ADDRESS}"
    else
      echo "No database found, therefore must do a full sync"
      echo
      echo "Start full sync of ${GMVAULT_EMAIL_ADDRESS}"

      gmvault sync \
        --db-dir ${GMVAULT_DIR} \
        --type full \
        ${GMVAULT_OPTIONS} ${GMVAULT_EMAIL_ADDRESS} 2>&1 \
        | tee -a ${GMVAULT_DIR}/gmvault_full.log

      echo "Completed full sync of ${GMVAULT_EMAIL_ADDRESS}"
    fi
  else
    echo "########################################################################"
    echo "#                                ERROR                                 #"
    echo "########################################################################"
    echo
    echo "No OAuth token at"
    echo "${OAUTH_TOKEN}"
    echo
    echo "See instructions at:"
    echo "https://github.com/gaubert/gmvault/issues/335#issuecomment-846483036"
    echo
    echo "########################################################################"
    echo

    if [ -t 0 ]; then
      echo
      echo "Starting shell..."
      echo

      exec "bash"
    else
      echo "An interactive shell was not detected."
      echo
      echo "By default, this container starts a bash shell, be sure you are passing '-it' to your run command."
      echo
      echo "Instead going to tail /dev/null to keep the container running"

      /usr/bin/tail -f /dev/null
    fi
  fi
else
  exec "$@"
fi
