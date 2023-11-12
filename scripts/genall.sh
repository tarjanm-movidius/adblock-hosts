#/bin/sh

HOSTS_TMP="hosts-$RANDOM"

cat ../data/* > $HOSTS_TMP
for i in gen_*.sh; do
	SUBM_NAME="`sed 's/gen_\(.*\)\.sh/\1/' <<< $i`"
	[ "$1" == "-f" -o ! -e "hosts_$SUBM_NAME" ] && ./$i
	grep -v '^#' "hosts_$SUBM_NAME" >> $HOSTS_TMP
done
cat hosts.hdr > ../hosts
sort -u "$HOSTS_TMP" >> ../hosts
rm "$HOSTS_TMP"
