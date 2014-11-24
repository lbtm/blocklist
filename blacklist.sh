#!/bin/sh
# A simple script that downloads all blacklists from (www.iblocklist.com) in the list, and saves them in my_big_blacklist
#

TRANSMISSION_DIR="/var/lib/transmission-daemon/.config/transmission-daemon/blocklists"
LIST="my_big_blacklist"
_URL="https://www.iblocklist.com/lists.php"

# Make my_big_blacklist
for url in $(curl -s $_URL | sed -e '/value=/! { d }' -e "/value='http/! { d }" -e "s/.*value='//g" -e "s/'.*//g"); do
        wget -q --content-disposition "${url}" -O - | gunzip >> $TRANSMISSION_DIR/my_big_blacklist
done

# Reload transmission-daemon
#service transmission-daemon reload
systemctl reload transmission-daemon
