#!/bin/sh

MYPATH="`dirname $0`"
SUBM_DIR="$MYPATH/../WindowsSpyBlocker"
LISTFILE="$MYPATH/adservers_WindowsSpyBlocker.txt"
HOSTFILE="$MYPATH/hosts_WindowsSpyBlocker"

echo "# `git -C $SUBM_DIR rev-parse HEAD`" > "$HOSTFILE"

grep -v '^#\|^$' $SUBM_DIR/data/hosts/spy.txt | sed 's/^0\.0\.0\.0 //' | tee "$LISTFILE" | sed 's/^/127\.0\.0\.1 /' >> "$HOSTFILE"
