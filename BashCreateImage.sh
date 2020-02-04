#!/bin/bash

dnf install -y gawk make wget tar bzip2 gzip python unzip findutils which perl patch diffutils diffstat bc cpio file git cpp gcc gcc-c++ gnupg glibc-devel texinfo chrpath openssl ccache perl-Data-Dumper perl-bignum perl-Text-ParseWords perl-Thread-Queue SDL-devel xterm iputils hostname procps net-tools iproute python-pip python-devel python-requests redhat-rpm-config openssl-devel rpm-devel rsync tar tmux xz uhd
dnf clean all
	
echo "export LANG=en_US.utf-8" > /opt/export_LANG.sh
git config --system user.name "Ettus OE Builder" && git config --system user.email "oe-builder@ettus.com"
curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > repo
chmod a+x repo
mv repo /usr/local/bin

cd $HOME

git clone git://github.com/openembedded/bitbake.git
git clone git://github.com/EttusResearch/meta-ettus.git
git clone git://github.com/mendersoftware/meta-mender.git
git clone git://github.com/openembedded/meta-openembedded.git
git clone git://git.yoctoproject.org/meta-security.git
git clone git://github.com/openembedded/openembedded-core.git
git clone git://git.yoctoproject.org/meta-qt4.git
git clone git://github.com/EttusResearch/meta-sdr.git
git clone git://git.yoctoproject.org/meta-tensorflow.git

git clone https://github.com/EjonesNI/BuildWithTensor.git
rm -f meta-ettus/contrib/setup_build_env.sh
mv BuildWithTensor/setup_build_env.sh meta-ettus/contrib/setup_build_env.sh
mv ./openembedded-core ./oe-core
dos2unix meta-ettus/contrib/setup_build_env.sh

mkdir sdk
cd sdk
wget http://files.ettus.com/e3xx_images/e3xx-release-4/oecore-x86_64-armv7ahf-vfp-neon-toolchain-nodistro.0.sh
chmod +x oecore-x86_64-armv7ahf-vfp-neon-toolchain-nodistro.0.sh
./oecore-x86_64-armv7ahf-vfp-neon-toolchain-nodistro.0.sh
/usr/local/oecore-x86_64
y
ls
source /usr/local/oecore-x86_64/environment-setup-armv7ahf-vfp-neon-oe-linux-gnueabi
echo $CC

cd $HOME
chmod +x meta-ettus/contrib/setup_build_env.sh
./meta-ettus/contrib/setup_build_env.sh e310_sg3

touch build/conf/sanity.conf

chmod +x meta-ettus/contrib/build_imgs_package.sh
./meta-ettus/contrib/build_imgs_package.sh e310_sg3
