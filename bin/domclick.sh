#!/bin/sh
# check https://wiki.archlinux.org/index.php/OpenVPN#DNS
# to get info on how to pull DNS config from server
sudo openvpn --config ~/Dropbox/vpn/domclick.ovpn \
  --auth-user-pass ~/Dropbox/vpn/auth/domclick \
  --script-security 2 \
  --up ~/Dropbox/vpn/pull-resolv-conf/client.up \
  --down ~/Dropbox/vpn/pull-resolv-conf/client.down
