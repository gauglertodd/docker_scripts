cd ~/docker_scripts/

git pull

cd ~/

./docker_scripts/build_python_deb.sh py2deb youtube-dl py4j setuptools numpy
sudo dpkg -i ~/py2deb/python-numpy_*.deb
sudo apt-get install -f -y --force-yes
./docker_scripts/build_python_deb.sh scipy pandas matplotlib mock nose pyparsing pbr
sudo dpkg -i ~/py2deb/python-scipy_*.deb
sudo apt-get install -f -y --force-yes
./docker_scripts/build_python_deb.sh scikit-learn scikit-image blaze gensim nltk
sudo dpkg -i ~/py2deb/python-pandas_*.deb ~/py2deb/python-matplotlib_*.deb \
        ~/py2deb/python-mock_*.deb ~/py2deb/python-nose_*.deb ~/py2deb/python-pyparsing_*.deb \
        ~/py2deb/python-pbr_*.deb
sudo apt-get install -f -y --force-yes
./docker_scripts/build_python_deb.sh statsmodels websockify sharedarray requests pysparkling cython
sudo dpkg -i ~/py2deb/cython_*.deb
sudo apt-get install -f -y --force-yes
./docker_scripts/build_python_deb.sh pystan seaborn theano patsy enum34 executor
sudo dpkg -i ~/py2deb/python-theano_*.deb 
sudo apt-get install -f -y --force-yes

sudo apt-get install -y libhdf5-dev
./docker_scripts/build_python_deb.sh lasagne nolearn scikit-neuralnetwork keras gdbn h5py
./docker_scripts/build_python_deb.sh git+https://github.com/ddboline/pylearn2.git
./docker_scripts/build_python_deb.sh git+https://github.com/ddboline/garmin_app.git
./docker_scripts/build_python_deb.sh git+https://github.com/ddboline/roku_app.git \
                                     git+https://github.com/ddboline/security_log_analysis.git \
                                     git+https://github.com/ddboline/sync_app.git

OPTS="--rename=pyyaml,python-yaml --rename=pyusb,python-usb --rename=websockify,websockify 
      --rename=scikit-learn,python-sklearn --rename=scikit-image,python-skimage 
      --rename=google-api-python-client,python-googleapi --rename=cython,cython
      --rename=pytz,python-tz --rename=pillow,python-pil
      --rename=beautifulsoup4,python-bs4"


sudo py2deb -r /home/${USER}/py2deb -y $OPTS -- --upgrade git+https://github.com/Tigge/openant.git
sudo dpkg -i ~/py2deb/python-usb_*.deb
sudo dpkg -i ~/py2deb/python-openant_*.deb
sudo apt-get install -f -y --force-yes
sudo py2deb -r /home/${USER}/py2deb -y $OPTS -- --upgrade git+https://github.com/Tigge/antfs-cli.git
sudo py2deb -r /home/${USER}/py2deb -y $OPTS -- --upgrade spacy

sudo chown ${USER}:${USER} ~/py2deb/*.deb

sudo apt-get install -y postgresql-server-dev-9.3
./docker_scripts/build_python_deb.sh psycopg2

./docker_scripts/build_fit2tcx.sh

./docker_scripts/build_python_deb.sh asyncio boltons beautifulsoup4 cssselect cytoolz lxml pandasql pillow
./docker_scripts/build_python_deb.sh git+https://github.com/ddboline/stravalib.git
./docker_scripts/build_python_deb.sh units xray sqlacodegen

./docker_scripts/build_python_deb.sh fuzzywuzzy spyder pymonad pyquery click pyscaffold onedrivesdk

./docker_scripts/build_python_deb.sh git+https://github.com/ddboline/compose.git

./docker_scripts/build_python_deb.sh pytest pytest-xdist pytest-instafail getlyrics

./docker_scripts/build_xgboost.sh

scp ~/py2deb/*.deb ddboline@ddbolineathome.mooo.com:~/setup_files/deb/py2deb/py2deb/
