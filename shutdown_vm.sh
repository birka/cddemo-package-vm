#/bin/bash

VM_NAME="CD_Demo"
SHUTDOWN_CMD='ssh heise@localhost -p 2222 sudo bash /usr/local/cddemo-utils/cleanup_and_shutdown.sh \"$(echo $$)\"'

VBOXMANAGE=/usr/bin/vboxmanage

WAIT_TIMEOUT=30
VM_WAS_RUNNING="no"

if [ ! -z "$($VBOXMANAGE list runningvms | grep ${VM_NAME})" ];then
  VM_WAS_RUNNING="yes"
  echo -n "Shutting down VM $VM_NAME."
  $SHUTDOWN_CMD &
  S=0
  while [ $S -lt ${WAIT_TIMEOUT} -a ! -z "$($VBOXMANAGE list runningvms | grep $VM_NAME)" ]
  do
    echo -n "."
    sleep 1
    S=$(expr $S + 1)
  done
  echo
  if [ $S -eq $WAIT_TIMEOUT ];then
    echo "ERROR: Couldn't shutdown VM $VM_NAME!"
    exit 1
  fi
fi
echo "VM_WAS_RUNNING="$VM_WAS_RUNNING
exit 0
