#
# Copyright (C) 2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=omcproxy
PKG_RELEASE:=8

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL=$(PROJECT_GIT)/project/omcproxy.git
PKG_SOURCE_DATE:=2018-12-16
PKG_SOURCE_VERSION:=722151f04348cf1b759613c087bced52fb45790a
PKG_MIRROR_HASH:=a246b9843e78efb609c88e132b6c24a819f946104bcc7876b09d1e8cd9f7660a
PKG_MAINTAINER:=Steven Barth <cyrus@openwrt.org>
PKG_LICENSE:=Apache-2.0

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

define Package/omcproxy
  SECTION:=net
  CATEGORY:=Network
  DEPENDS:=+libubox +libubus
  TITLE:=IGMPv3 and MLDv2 Multicast Proxy
endef

CMAKE_OPTIONS += -DWITH_LIBUBOX=1

define Package/omcproxy/install
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/omcproxy.config $(1)/etc/config/omcproxy
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/omcproxy.init $(1)/etc/init.d/omcproxy
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/omcproxy $(1)/usr/sbin/
endef

$(eval $(call BuildPackage,omcproxy))
