#/bin/sh

MYPATH="`dirname $0`"

git -C "$MYPATH/.." submodule update --recursive --remote
for i in $MYPATH/../.git/modules/*; do
	git -C "$i" gc --keep-largest-pack
done
"$MYPATH/genall.sh" -f
