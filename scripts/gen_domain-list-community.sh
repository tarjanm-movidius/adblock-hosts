#!/bin/sh

SUBM_DIR="../domain-list-community"
LISTFILE="adservers_domain-list-community.txt"
HOSTFILE="hosts_domain-list-community"

echo "# `git -C $SUBM_DIR rev-parse HEAD`" > "$HOSTFILE"

cat $SUBM_DIR/data/* | grep "@ads" | grep -v ':' | sort -u | sed 's/ @ads$//' | tee "$LISTFILE" | sed 's/^/127\.0\.0\.1 /' >> "$HOSTFILE"
