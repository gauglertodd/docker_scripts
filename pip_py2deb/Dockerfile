# Base docker image
FROM ddboline/ddboline_keys:latest
MAINTAINER Daniel Boline <ddboline@gmail.com>

RUN sudo bash -c "echo deb ssh://ddboline@ddbolineathome.mooo.com/var/www/html/deb/xenial/devel ./ > /etc/apt/sources.list.d/py2deb.list"
RUN sudo apt-get update
RUN sudo apt-get -o Dpkg::Options::="--force-overwrite" install -y \
                                        python-pip python-dev lintian liblapack-dev libblas-dev \
                                        dpkg-dev gfortran libfreetype6-dev libpng12-dev pkg-config \
                                        python-setuptools python-py2deb git-buildpackage
RUN mkdir -p /home/ubuntu/py2deb
RUN sudo apt-get autoremove && sudo apt-get autoclean && sudo rm -rf /var/cache/apt/archives/*.deb
