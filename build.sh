#!/bin/sh

set -e
set -x

cd /opt/build

MIX_ENV=prod mix deps.get
MIX_ENV=prod mix do clean, compile, release --env=prod

export VERSION="$(eval 'echo $VERSION')"

echo "Exporting release tarball.."
cp /opt/build/_build/prod/rel/$APP/releases/$VERSION/$APP.tar.gz /opt/build/releases/
echo "Success!"
