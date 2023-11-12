#!/bin/bash

# gzip < dns.log > dns_ads.log.gz && echo -n "" > dns.log && killall -HUP dnsmasq
DNSSRV="pasaje"	# comment out for localhost
DNSLOG="dns_ads.log"
[ -d /dev/shm/tmp/ ] && DEVSHMTMP="/dev/shm/tmp/$RANDOM/" && mkdir "$DEVSHMTMP" || DEVSHMTMP=""
ALL_SERVERS="${DEVSHMTMP}dns_all_servers.txt"
NONBLOCKED_SERVERS="${DEVSHMTMP}dns_nb_servers.txt"
ZIPPER="`which pigz 2>/dev/null || which gzip`"
if [ -n "$DNSSRV" ]; then
	[ ! -e "hosts" ] && scp -O $DNSSRV:/etc/hosts .
	HOSTS="hosts"
	if [ ! -e "$DNSLOG" ]; then
		[ ! -e "$DNSLOG.gz" ] && scp -O $DNSSRV:$DNSLOG.gz .
		[ ! -e "$DNSLOG.gz" ] && echo "'$DNSLOG.gz' missing" 1>&2 && exit 1
	fi
else
	HOSTS="/etc/hosts"
fi
[ -n "$DEVSHMTMP" ] && cp "$HOSTS" "$DEVSHMTMP" && HOSTS="${DEVSHMTMP}hosts"

( [ -e "$DNSLOG.gz" ] && $ZIPPER -d < "$DNSLOG.gz" || cat "$DNSLOG" ) | sed 's/.*\]: [^ ]\+ \([^ ]\+\).*/\1/' | sort -u > "$ALL_SERVERS"
echo -n "" > "$NONBLOCKED_SERVERS"
for i in `cat "$ALL_SERVERS"`; do
	grep -q "$i$" "$HOSTS" && continue
	echo "$i" >> "$NONBLOCKED_SERVERS"
done
grep "ads\|\bad\|analytics" "$NONBLOCKED_SERVERS" | grep -v "uploads\|downloads\|addon\|iadsdk.*apple.com\|in-addr\.arpa\|adjust\.com\|\.profile.*cloudfront\.net\|vod-adaptive\.akamaized\.net"
[ -n "$DEVSHMTMP" ] && cp "$ALL_SERVERS" "$NONBLOCKED_SERVERS" . && rm -rf "$DEVSHMTMP"
