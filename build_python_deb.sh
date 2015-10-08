#!/bin/bash

OPTS="--rename=pyyaml,python-yaml --rename=pyusb,python-usb --rename=websockify,websockify 
      --rename=scikit-learn,python-sklearn --rename=scikit-image,python-skimage 
      --rename=google-api-python-client,python-googleapi --rename=cython,cython
      --rename=pytz,python-tz --rename=pillow,python-pil
      --rename=beautifulsoup4,python-bs4"

REPOS="py2deb youtube-dl py4j setuptools
       numpy scipy pandas scikit-learn scikit-image
       blaze gensim nltk statsmodels websockify sharedarray
       requests pysparkling cython pystan seaborn matplotlib
       theano lasagne nolearn scikit-neuralnetwork keras gdbn
       git+https://github.com/ddboline/pylearn2.git
       git+https://github.com/ddboline/stravalib.git
       git+https://github.com/ddboline/garmin_app.git
       git+https://github.com/ddboline/roku_app.git
       git+https://github.com/ddboline/security_log_analysis.git
       git+https://github.com/ddboline/sync_app.git
       git+https://github.com/Tigge/openant.git
       git+https://github.com/Tigge/antfs-cli.git
       "

REPOS="$@"
if [ -z "$REPOS" ]; then
    REPOS=""
fi

if [ ! -e "/usr/bin/py2deb" ]; then
    sudo bash -c "echo deb ssh://ddboline@ddbolineathome.mooo.com/var/www/html/deb/trusty/pip_py2deb ./ > /etc/apt/sources.list.d/py2deb2.list"
    sudo apt-get update
    sudo apt-get install -y --force-yes python-pip python-dev lintian liblapack-dev libopenblas-dev \
                                dpkg-dev gfortran libfreetype6-dev libpng12-dev pkg-config \
                                python-setuptools python-py2deb
    mkdir -p /home/${USER}/py2deb
fi

md5sum /home/${USER}/py2deb/*.deb > existing.log

for REPO in $REPOS;
do
    py2deb -r /home/${USER}/py2deb -y $OPTS -- --upgrade $REPO
done

md5sum /home/${USER}/py2deb/*.deb > modified.log
MODIFIED=`diff -u existing.log modified.log | awk '$1 ~ /\+/ && $1 != "+++" {I=I" "$2} END{print I}'`
if [ -n "$MODIFIED" ]; then
    ssh ddboline@ddbolineathome.mooo.com "mkdir -p /home/ddboline/setup_files/deb/py2deb/py2deb"
    scp $MODIFIED ddboline@ddbolineathome.mooo.com:/home/ddboline/setup_files/deb/py2deb/py2deb/
fi
