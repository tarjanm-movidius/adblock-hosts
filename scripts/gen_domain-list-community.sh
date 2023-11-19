#!/bin/sh

MYPATH="`dirname $0`"
SUBM_DIR="$MYPATH/../domain-list-community"
LISTFILE="$MYPATH/adservers_domain-list-community.txt"
HOSTFILE="$MYPATH/hosts_domain-list-community"

echo "# `git -C $SUBM_DIR rev-parse HEAD`" > "$HOSTFILE"

cat $SUBM_DIR/data/* | grep "@ads" | grep -v ':' | sort -u | sed 's/ @ads$//' | tee "$LISTFILE" | sed 's/^/127\.0\.0\.1 /' >> "$HOSTFILE"
