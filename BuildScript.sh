#!/bin/bash

dnf install -y gawk make wget tar bzip2 gzip python3 unzip uhd findutils which perl patch diffutils diffstat bc cpio file git cpp gcc gcc-c++ gnupg glibc-devel texinfo chrpath openssl ccache perl-Data-Dumper perl-bignum perl-Text-ParseWords perl-Thread-Queue SDL-devel xterm iputils hostname procps net-tools iproute python-pip python-devel python-requests redhat-rpm-config openssl-devel rpm-devel rsync tar tmux xz python2

mkdir ~/bin
PATH=~/bin:$PATH
git config --system user.name "Ettus OE Builder" && git config --system user.email "oe-builder@ettus.com"
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo

dnf install -y asciidoc gettext-devel tar autoconf xmlto
wget https://github.com/git/git/archive/v2.25.0.tar.gz

tar -zxf v2.25.0.tar.gz
cd v2.25.0
make configure
./configure --prefix=/usr
make all doc info
make install install-doc install-html install-info

mv setup_build_env.sh /root
dnf install -y wget
cd $HOME
repo init -u git://github.com/EttusResearch/oe-manifests.git -b thud
repo sync

ls
pwd
rm -rf meta-ettus
dnf install -y uhd unzip
dnf install -y unzip
wget https://github.com/EttusResearch/meta-ettus/archive/thud.zip

unzip thud.zip -d /root/
git clone git://github.com/EjonesNI/meta-tensorflow.git -b EjonesNI-patch-1
mv meta-ettus-thud meta-ettus
chmod +x ./meta-ettus/contrib/build_imgs_package.sh
dos2unix setup_build_env.sh
mv setup_build_env.sh meta-ettus/contrib/setup_build_env.sh
chmod +x meta-ettus/contrib/setup_build_env.sh

./meta-ettus/contrib/setup_build_env.sh e310_sg3 e310_sg3

touch build/conf/sanity.conf

#./meta-ettus/contrib/build_imgs_package.sh e310_sg3 e310_sg3
