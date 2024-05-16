K-Wrt 21.06
============

Based on OpenWrt Lede

### Introduction

Support the old router firmware, such as ar71xx, etc.

### Build

* 01. System

Ubuntu 20.24 or 22.04

* 02. Packages

> sudo apt update
> sudo apt install ack asciidoc autoconf automake autopoint binutils bison build-essential \
> bzip2 ccache cmake cpio curl device-tree-compiler fastjar flex gawk gettext gcc-multilib g++-multilib \
> git gperf haveged help2man intltool libc6-dev-i386 libelf-dev libfuse-dev libglib2.0-dev libgmp3-dev \
> libltdl-dev libmpc-dev libmpfr-dev libncurses5-dev libncursesw5-dev libpython3-dev libreadline-dev \
> libssl-dev libtool lrzsz mkisofs msmtp ninja-build p7zip p7zip-full patch pkgconf python2.7 python3 \
> python3-pyelftools python3-setuptools qemu-utils rsync scons squashfs-tools subversion swig texinfo \
> upx-ucl unzip vim wget xmlto xxd zlib1g-dev

* 03. Update and install feeds packages

> ./scripts/feeds update -a
> ./scripts/feeds install -a

* 04. Choose device mode

> make menuconfig

* 05. Start complie

> make -j 8

For debug:

> make V=sc -j 1

