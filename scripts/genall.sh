#/bin/sh

MYPATH="`dirname $0`"
HOSTS_TMP="hosts-$RANDOM"

cat $MYPATH/../data/* > $HOSTS_TMP
for i in $MYPATH/gen_*.sh; do
	HF_NAME="`sed 's/gen_\(.*\)\.sh/hosts_\1/' <<< $i`"
	[ "$1" == "-f" -o ! -e "$HF_NAME" ] && ./$i
	grep -v '^#' "$HF_NAME" >> $HOSTS_TMP
done
cat $MYPATH/hosts.hdr > $MYPATH/../hosts
sort -u "$HOSTS_TMP" >> $MYPATH/../hosts
rm "$HOSTS_TMP"
