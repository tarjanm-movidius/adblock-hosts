#!/bin/sh

MYPATH="`dirname $0`"
SUBM_DIR="$MYPATH/../StevenBlack"
LISTFILE="$MYPATH/adservers_StevenBlack.txt"
HOSTFILE="$MYPATH/hosts_StevenBlack"

echo "# `git -C $SUBM_DIR rev-parse HEAD`" > "$HOSTFILE"

grep '^0\.0\.0\.0 ' $SUBM_DIR/hosts | sed 's/^0\.0\.0\.0 //' | tee "$LISTFILE" | sed 's/^/127\.0\.0\.1 /' >> "$HOSTFILE"
