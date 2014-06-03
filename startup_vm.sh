#/bin/bash

VM_NAME="CD_Demo"

VBOXMANAGE=/usr/bin/vboxmanage
STARTUP_CMD="$VBOXMANAGE startvm $VM_NAME --type headless"

WAIT_TIMEOUT=60

if [ -z "$($VBOXMANAGE list runningvms | grep ${VM_NAME})" ];then
  echo -n "Starting up VM $VM_NAME."
  $STARTUP_CMD &
  S=0
  while [ $S -lt ${WAIT_TIMEOUT} -a -z "$($VBOXMANAGE list runningvms | grep $VM_NAME)" ]
  do
    echo -n "."
    sleep 1
    S=$(expr $S + 1)
  done
  echo
  if [ $S -eq $WAIT_TIMEOUT ];then
    echo "ERROR: Couldn't startup VM $VM_NAME!"
    exit 1
  fi
fi
exit 0
