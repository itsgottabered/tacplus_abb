#!/usr/bin/env bash

retries=5
wait_retry=5
command="/etc/init.d/tacacs_plus start"

for i in `seq 1 $retries`; do
    echo "$command"
    $command
    ret_value=$?
    [ $ret_value -eq 0 ] && break
    echo "> failed with $ret_value, waiting to retry..."
    sleep $wait_retry
done

exit $ret_value
