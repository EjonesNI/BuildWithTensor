#!/bin/bash

dnf install -y gawk make wget tar bzip2 gzip python unzip findutils which perl patch diffutils diffstat bc cpio file git cpp gcc gcc-c++ gnupg glibc-devel texinfo chrpath openssl ccache perl-Data-Dumper perl-bignum perl-Text-ParseWords perl-Thread-Queue SDL-devel xterm iputils hostname procps net-tools iproute python-pip python-devel python-requests redhat-rpm-config openssl-devel rpm-devel rsync tar tmux xz uhd
dnf clean all
	
echo "export LANG=en_US.utf-8" > /opt/export_LANG.sh
git config --system user.name "Ettus OE Builder" && git config --system user.email "oe-builder@ettus.com"
curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > repo
chmod a+x repo
mv repo /usr/local/bin

mkdir sdk
cd sdk
wget http://files.ettus.com/e3xx_images/e3xx-release-4/oecore-x86_64-armv7ahf-vfp-neon-toolchain-nodistro.0.sh
chmod +x oecore-x86_64-armv7ahf-vfp-neon-toolchain-nodistro.0.sh
./oecore-x86_64-armv7ahf-vfp-neon-toolchain-nodistro.0.sh -y -d /usr/local/oecore-x86_64
source /usr/local/oecore-x86_64/environment-setup-armv7ahf-vfp-neon-oe-linux-gnueabi
echo $CC

cd $HOME
repo init -u git://github.com/EJonesNI/oe-manifests.git -b Tensorflow
repo sync

chmod +x meta-ettus/contrib/setup_build_env.sh
./meta-ettus/contrib/setup_build_env.sh e310_sg3 v1.0.0.0

touch build/conf/sanity.conf

chmod +x meta-ettus/contrib/build_imgs_package.sh
./meta-ettus/contrib/build_imgs_package.sh e310_sg3 v1.0.0.0
