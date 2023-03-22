#!/bin/bash

set -ue

if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit 1
fi

NAGIOS_INSTALL='/usr/local/nagios'

# Check that nagios is installed
if [ ! -d "$NAGIOS_INSTALL" ]; then
        echo "Unable to detect nagios installation at $NAGIOS_INSTALL."
        echo "Please install nagios core with install_nagios.sh"
        exit 2
fi

echo 'Nagios Install detected'

COMMANDDIR="$NAGIOS_INSTALL/etc/commands"

# Stuff configs into nagios if they dont already exist there
if [[ ! "$(cat $NAGIOS_INSTALL/etc/nagios.cfg | grep 'cfg_dir=/usr/local/nagios/etc/commands')" ]]; then
        sed -i '0,/cfg_dir=/{s/cfg_dir=/cfg_dir=\/usr\/local\/nagios\/etc\/commands\n&/}' '/usr/local/nagios/etc/nagios.cfg'
fi

mkdir -p "$COMMANDDIR"

cp 'slack-host.cfg' "$COMMANDDIR"
cp 'slack-service.cfg' "$COMMANDDIR"
cp 'slack_service_notify.sh' "$NAGIOS_INSTALL/libexec"
cp 'slack_host_notify.sh' "$NAGIOS_INSTALL/libexec"

chmod 777 "$NAGIOS_INSTALL/libexec/slack_service_notify.sh"
chmod 777 "$NAGIOS_INSTALL/libexec/slack_host_notify.sh"

if $(systemctl restart nagios); then
        echo "Restarted Nagios"
else
        echo "Unable to restart nagios, likely due to a config error"
fi
