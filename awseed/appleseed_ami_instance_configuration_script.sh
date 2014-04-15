#!/bin/sh

# AMI instance will run this as root
# AMI has limitation that this file is < 16kB in size

apt-get -y install build-essential
apt-get -y install llvm
# apt-get -y install cmake
apt-get -y install unzip
apt-get -y install libboost1.48-all-dev
apt-get -y install python-numpy
apt-get -y install libhdf5-serial-dev
# apt-get -y install cmake-curses-gui
apt-get -y install emacs23-nox
apt-get -y install mesa-common-dev
apt-get -y install freeglut3-dev
apt-get -y install libglew1.6-dev
apt-get -y install libxi-dev
apt-get -y install libxmu-dev
apt-get -y install qt4-dev-tools
apt-get -y install doxygen
apt-get -y install libncurses5-dev
apt-get -y install libpng12-dev
echo "APT-GET DONE" >> /tmp/status.log

# Get appleseed source
cd /tmp
wget https://github.com/appleseedhq/appleseed/archive/1.1.0-alpha-21-preview-2.tar.gz
wget http://alembic.googlecode.com/archive/1_05_04.zip
wget http://download.savannah.gnu.org/releases/openexr/pyilmbase-2.1.0.tar.gz
wget http://download.savannah.nongnu.org/releases/openexr/openexr-2.1.0.tar.gz
wget http://download.savannah.nongnu.org/releases/openexr/ilmbase-2.1.0.tar.gz
wget https://dl.dropboxusercontent.com/u/21295005/AmazonWebServices/patches/patch_alembic_1_5_4.txt
# Pre-built HDF5 on Ubuntu uses v1.6 API which is not compatible with Alembic's requirement
wget http://www.hdfgroup.org/ftp/HDF5/current/src/hdf5-1.8.12.tar.bz2 
# Appleseed requires CMake v2.8.12 otherwise it is consider a failure to bootstrap
http://www.cmake.org/files/v2.8/cmake-2.8.12.2.tar.gz
echo "WGET DONE" >> /tmp/status.log

# ILMBase
if true
then
    echo "ILMBASE BUILD/INSTALL START" >> /tmp/status.log
    pushd /tmp
    zcat /tmp/ilmbase-2.1.0.tar.gz | tar -xf -
    cd ilmbase-2.1.0
    ./configure --with-pic
    make install > ilmbase.log 2>&1
    ldconfig -v
    popd
    echo "ILMBASE BUILD/INSTALL DONE" >> /tmp/status.log
fi

# PyILMBase
if true
then
    echo "PYILMBASE BUILD/INSTALL START" >> /tmp/status.log
    pushd /tmp
    zcat /tmp/pyilmbase-2.1.0.tar.gz | tar -xf -
    cd pyilmbase-2.1.0
    ./configure --with-pic --disable-ilmbasetest
    make install > /tmp/pyilmbase.log 2>&1
    ldconfig -v
    popd
    echo "PYILMBASE BUILD/INSTALL DONE" >> /tmp/status.log
fi

# OpenEXR
if true
then
    echo "OPENEXR BUILD/INSTALL START" >> /tmp/status.log
    pushd /tmp
    zcat /tmp/openexr-2.1.0.tar.gz | tar -xf -
    cd openexr-2.1.0
    ./configure --with-pic --disable-ilmbasetest
    make install > /tmp/openexr.log 2>&1
    ldconfig -v
    popd
    echo "OPENEXR BUILD/INSTALL DONE" >> /tmp/status.log
fi

# HDF5 1.8 API
if true
then
    echo "HDF5 BUILD/INSTALL START" >> /tmp/status.log
    pushd /tmp
    bzcat /tmp/hdf5-1.8.12.tar.bz2 | tar -xf -
    cd hdf5-1.8.12
    ./configure --with-pic --enable-hl --prefix=/usr/local
    make install
    ldconfig -v
    popd
    echo "OPENEXR BUILD/INSTALL DONE" >> /tmp/status.log
fi

# CMake
if true
then
    echo "CMAKE BUILD/INSTALL START" >> /tmp/status.log
    pushd /tmp
    zcat /tmp/cmake-2.8.12.2.tar.gz | tar -xf -
    cd cmake-2.8.12.2
    ./configure
    make install
    ldconfig -v
    popd
    echo "CMAKE BUILD/INSTALL DONE" >> /tmp/status.log
fi

# Alembic
if true
then
    echo "ALEMBIC BUILD/INSTALL START" >> /tmp/status.log
    pushd /tmp
    unzip /tmp/1_05_04.zip
    mkdir build_alembic
    cd build_alembic
    cmake -D USE_LIB64=OFF -D LIBPYTHON_VERSION=2.7 -D USE_PYALEMBIC=ON ../alembic-1786c22d4ce0
    make install
    ldconfig -v
    popd
    echo "ALEMBIC BUILD/INSTALL END" >> /tmp/status.log
fi
