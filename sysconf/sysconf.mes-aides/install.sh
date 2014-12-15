# Installer script for sysconf "mes-aides"  -*- shell-script -*-

. /usr/lib/sysconf.base/common.sh

_packages=
_packages="$_packages mongodb-server"
# These are required to build the dependencies of NodeJS app "mes-aides"
_packages="python g++ make"
sysconf_require_packages $_packages

# setup MongoDB replica
if ! echo -e "use local\nshow collections" | mongo | grep -q oplog.rs; then
    echo "Activating the MongoDB replica..."
    # for i in 1 2 3 4 5; do netstat -tlpn | grep mongo; sleep 1; done
    echo -e "use local\nrs.initiate()" | mongo
    service mongodb restart
    sleep 2
fi

# Install grunt globally
npm install -g grunt-cli

# "mes-aides" UNIX account
grep -q ^mes-aides: /etc/passwd || {
    useradd -d /var/lib/mes-aides mes-aides
}

# Install mes-aides
# if [ ! -d /var/lib/mes-aides ]; then
#     cd /var/lib
#     git clone https://github.com/sgmap/mes-aides-ui.git -b 48262f692476387f9891b3d0dd04f5b9077b9c29 --depth 1
#     cd mes-aides
#     chown -R mes-aides:mes-aides .
#     sudo -u mes-aides -g mes-aides npm install
# fi
