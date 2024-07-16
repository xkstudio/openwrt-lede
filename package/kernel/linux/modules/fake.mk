#
# Copyright (C) 2024 OpenWrt.org
#
# Fake kernel modules
#

FK_MENU:=Fake Extensions

###
### Fake kmod-nft-tproxy for v2rayA
### Date: 2024-07-16
###
define KernelPackage/nft-tproxy
  SUBMENU:=$(FK_MENU)
  TITLE:= Fake for nft-tproxy
endef

$(eval $(call KernelPackage,nft-tproxy))

