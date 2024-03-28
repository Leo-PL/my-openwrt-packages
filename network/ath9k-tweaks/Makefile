include $(TOPDIR)/rules.mk

PKG_NAME:=ath9k-tweaks
PKG_VERSION:=1.0
PKG_RELEASE:=0
PKG_MAINTAINER:=Lech Perczak <lech.perczak@gmail.com>

PKG_LICENSE:=GPL-2.0
PKG_LICENSE_FILES:=

PKGARCH:=all

include $(INCLUDE_DIR)/package.mk

define Package/ath9k-tweaks
  SECTION:=network
  CATEGORY:=Network
  SUBMENU:=Wireless
  TITLE:=Collection of tweaks for ath9k wireless interfaces
  DEPENDS:=kmod-ath9k
endef

define Package/ath9k-tweaks/description
  Collection of tweaks for ath9k wireless interfaces.
  Currently only a TX queue size optimization.
endef

define Build/Compile
	true
endef

define Package/ath9k-tweaks/install
	$(CP) ./files/* $(1)/
endef

$(eval $(call BuildPackage,ath9k-tweaks))
