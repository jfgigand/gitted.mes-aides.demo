# Installer script for sysconf "mes-aides"  -*- shell-script -*-

. /usr/lib/sysconf.base/common.sh

apt_get="apt-get --yes -o Dpkg::Options::=--force-confdef"

_packages=
_packages="$_packages mongodb-server"
_packages="$_packages ruby ruby-dev"
# These are required to build the dependencies of NodeJS app "mes-aides"
_packages="$_packages python g++ make bzip2"
sysconf_require_packages $_packages

# setup MongoDB replica
if ! echo -e "use local\nshow collections" | mongo | grep -q oplog.rs; then
    echo "Activating the MongoDB replica..."
    echo -e "use local\nrs.initiate()" | mongo
    service mongodb restart
    sleep 2
fi

# Install grunt, bower and forever globally
for module in grunt-cli bower forever; do
    if ! npm list -g $module >/dev/null; then
        npm install -g $module
    fi
done

# Install Compass through Ruby (CSS processor) if not installed
if [ -z "$(which compass)" ]; then
    # sysconf_require_packages ruby-dev
    gem install compass
    # $apt_get purge ruby-dev
    # $apt_get autoremove
fi

# "mes-aides" UNIX account
grep -q ^mes-aides: /etc/passwd || {
    useradd -d /var/lib/mes-aides mes-aides
}
as_user="sudo -u mes-aides -g mes-aides"

# Install mes-aides
if [ ! -d /var/lib/mes-aides ]; then
    cd /var/lib
    # branch=48262f692476387f9891b3d0dd04f5b9077b9c29
    branch=master
    git clone https://github.com/sgmap/mes-aides-ui.git \
        -b $branch --depth 1 mes-aides \
        || nef_fatal "could not clone GIT repos for: mes-aides-ui"
    cd mes-aides
    cat <<EOF >server
#!/usr/bin/nodejs
require("./server.js");
EOF
    chmod +x server
    chown -R mes-aides:mes-aides .
    $as_user npm install || nef_fatal "could not install NPM modules for mes-aides"
    $as_user bower install || nef_fatal "could not run 'bower install'"
    $as_user grunt build || nef_fatal "could not run 'grunt build'"

fi

# (re)Start the service through /etc/init.d/mes-aides
if service mes-aides status >/dev/null; then
    service mes-aides restart || nef_fatal "could not restart mes-aides"
else
    service mes-aides start || nef_fatal "could not start mes-aides"
fi
