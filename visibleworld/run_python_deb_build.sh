#!/bin/bash

sudo apt-get update
sudo apt-get -o Dpkg::Options::="--force-overwrite" dist-upgrade -y
sudo apt-get install -y postgresql-server-dev-9.5 libhdf5-dev libxml2-dev \
                        libxslt1-dev libpython2.7-dev freetds-bin freetds-dev \
                        udev libgeos++-dev

md5sum /home/${USER}/py2deb/*.deb > existing.log
for PKG in `cat run_python_deb_pkgs.txt`;
do
    ./build_python_deb.sh $PKG
    md5sum /home/${USER}/py2deb/*.deb > modified.log
    MODIFIED=`diff -u existing.log modified.log | awk '$1 ~ /\+/ && $1 != "+++" {I=I" "$2} END{print I}'`
    sudo dpkg --force-overwrite -i $MODIFIED
    sudo apt-get -o Dpkg::Options::="--force-overwrite" install -f -y --force-yes
    mv modified.log existing.log
done

MODIFIED=/home/${USER}/py2deb/*.deb
if [ -n "$MODIFIED" ]; then
    scp $MODIFIED ddboline@danielb.visibleworld.com:/home/ddboline/setup_files/deb/py2deb/py2deb/
fi
