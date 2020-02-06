#!/bin/bash

dnf install -y gawk rpcgen patch diffstat python2 glibc-devel python3 glibc-devel.i686 chrpath gcc-c++ texinfo make wget tar bzip2 gzip python unzip findutils which perl patch diffutils diffstat bc cpio file git cpp gcc gcc-c++ gnupg glibc-devel texinfo chrpath openssl ccache perl-Data-Dumper perl-bignum perl-Text-ParseWords perl-Thread-Queue SDL-devel xterm iputils hostname procps net-tools iproute python-pip python-devel python-requests redhat-rpm-config openssl-devel rpm-devel rsync tar tmux xz uhd

mkdir sdk
cd sdk
wget http://files.ettus.com/e3xx_images/e3xx-release-4/oecore-x86_64-armv7ahf-vfp-neon-toolchain-nodistro.0.sh
chmod +x oecore-x86_64-armv7ahf-vfp-neon-toolchain-nodistro.0.sh
./oecore-x86_64-armv7ahf-vfp-neon-toolchain-nodistro.0.sh -y -d /usr/local/oecore-x86_64
source /usr/local/oecore-x86_64/environment-setup-armv7ahf-vfp-neon-oe-linux-gnueabi
echo $CC

cd $HOME
rm -rf meta-oe
git clone -n git://github.com/openembedded/meta-openembedded.git
cd meta-openembedded
git checkout 4cd3a39f22a2712bfa8fc657d09fe2c7765a4005
cd ../
mv meta-openembedded meta-oe
rm -rf oe-core
git clone -n git://github.com/openembedded/openembedded-core.git
cd openembedded-core
git checkout f162d5bfe6eaeca24f441c83c87252c8d05744fc
cd ../
mv openembedded-core oe-core
rm -rf meta-security
git clone -n git://git.yoctoproject.org/meta-security.git
cd meta-security
git checkout 31dc4e7532fa7a82060e0b50e5eb8d0414aa7e93
cd ../
rm -rf meta-qt4
git clone -n git://git.yoctoproject.org/meta-qt4.git
cd meta-qt4
git checkout b37d8b93924b314df3591b4a61e194ff3feb5517
cd ../
rm -rf meta-sdr
git clone -n git://github.com/EttusResearch/meta-sdr.git
cd meta-sdr
git checkout 5bfb24d4005fa38fff9b772f6686dd5ad09b7703
cd ../
rm -rf meta-mender
git clone -n git://github.com/mendersoftware/meta-mender
cd meta-mender
git checkout 761a4c5277decb80154ca239745b40a206ffc05e
cd ../
rm -rf meta-ettus
git clone -n git://github.com/EjonesNI/meta-ettus.git
cd meta-ettus
git checkout 60b9a5470fe5cb02f93894d8ef9dd1faf1d3b79d
cd ../
rm -rf meta-tensorflow
git clone -n git://github.com/EjonesNI/meta-tensorflow.git
cd meta-tensorflow
git checkout 247916f171680c7bb78b6f18c5970bd85a377706
cd ../
rm -rf bitbake
git clone -n git://github.com/openembedded/bitbake.git
cd bitbake
git checkout 79e62eef1c93f742bf71e9f25db57fdd2ffedd02
cd ../

chmod +x meta-ettus/contrib/setup_build_env.sh
./meta-ettus/contrib/setup_build_env.sh e310_sg3 v1.0.0.0

touch build/conf/sanity.conf

chmod +x meta-ettus/contrib/build_imgs_package.sh
./meta-ettus/contrib/build_imgs_package.sh e310_sg3 v1.0.0.0
