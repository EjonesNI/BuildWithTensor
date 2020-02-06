#!/bin/bash

dnf install -y gawk make wget tar bzip2 gzip python unzip findutils which perl patch diffutils diffstat bc cpio file git cpp gcc gcc-c++ gnupg glibc-devel texinfo chrpath openssl ccache perl-Data-Dumper perl-bignum perl-Text-ParseWords perl-Thread-Queue SDL-devel xterm iputils hostname procps net-tools iproute python-pip python-devel python-requests redhat-rpm-config openssl-devel rpm-devel rsync tar tmux xz

cd $HOME
repo init -u git://github.com/EttusResearch/oe-manifests.git -b thud
repo sync

ls
pwd
rm -rf meta-ettus
dnf install uhd unzip

wget https://github.com/EttusResearch/meta-ettus/archive/thud.zip

unzip thud.zip -d /root/
chmod +x ./meta-ettus/contrib/build_imgs_package.sh
chmod +x meta-ettus/contrib/setup_build_env.sh

./meta-ettus/contrib/setup_build_env.sh e310_sg3

touch build/conf/sanity.conf

./meta-ettus/contrib/build_imgs_package.sh e310_sg3