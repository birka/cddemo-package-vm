#/bin/bash

VM_NAME="CD_Demo"
SHUTDOWN_CMD='ssh heise@localhost -p 2222 sudo shutdown -h now'

VBOXMANAGE=/usr/bin/vboxmanage

WAIT_TIMEOUT=30

if [ ! -z "$($VBOXMANAGE list runningvms | grep ${VM_NAME})" ];then
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

