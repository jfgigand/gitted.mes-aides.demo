# Installer script for sysconf "nodejs"         -*- shell-script -*-

. /usr/lib/sysconf.base/common.sh

# Install NodeJS and fix bon/node -> nodejs
_packages=
_packages="$_packages nodejs"

sysconf_require_packages $_packages

[ -x /usr/bin/node ] || ln -s nodejs /usr/bin/node

# Install NPM
if [ ! -x /usr/bin/npm ]; then
    nef_log "Installing NPM..."
    sh npmjs.install.sh \
        || nef_fatal "could not install npm"
fi
