include $(TOPDIR)/rules.mk

PKG_NAME:=persistent-serial
PKG_VERSION:=1.0
PKG_RELEASE:=0
PKG_MAINTAINER:=Lech Perczak <lech.perczak@gmail.com>

PKG_LICENSE:=GPL-2.0
PKG_LICENSE_FILES:=

PKGARCH:=all

include $(INCLUDE_DIR)/package.mk

define Package/persistent-serial
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=Persistent USB-serial port name generator
endef

define Package/persistent-serial/description
  A tiny script to generate /dev/serial/by-id/* and /dev/serial/by-path/*
  persistent symbolic links fo USB-serial devices, reminescent of udev.
endef

define Build/Compile
	true
endef

define Package/persistent-serial/install
	$(CP) ./files/* $(1)/
endef

$(eval $(call BuildPackage,persistent-serial))
