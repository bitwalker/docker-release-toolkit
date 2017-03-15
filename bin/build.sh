#!/bin/sh

set -e
set -x

cd /opt/build

MIX_ENV=prod mix do clean, compile, release --env=prod

echo "Exporting release tarball.."
cp /opt/build/_build/rel/prod/$APP/releases/$VERSION/$APP.tar.gz /opt/build/releases/
echo "Success!"
