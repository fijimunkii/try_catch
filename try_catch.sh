#!/usr/bin/env bash

set -e
set -u
set -o pipefail

try_fn() {
  fn &
  wait $! || {
    EXIT_CODE=$?
    echo $EXIT_CODE
  }
}
fn() {
  set -e
  exit 66  
}

TRIES=0
RESULT=""
until [ "$RESULT" = "OK" ]; do
  TRIES=$((TRIES+1))
  [ $TRIES -ge 5 ] && {
    echo "ERROR: MAX_TRIES" && exit 555
  }
  RESULT=`try_fn`;
done 

echo "RESULT=$RESULT"
echo "TRIES=$TRIES"
