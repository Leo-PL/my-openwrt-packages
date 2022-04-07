include $(TOPDIR)/rules.mk
 
PKG_NAME:=tcpser
PKG_VERSION:=1.1.4
PKG_RELEASE:=1
PKG_LICENSE:=GPL-2.0-or-later
 
PKG_BUILD_DIR:=$(BUILD_DIR)/tcpser-$(PKG_VERSION)
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/go4retro/tcpser.git
PKG_SOURCE_DATE:=2020-11-22
PKG_SOURCE_VERSION:=234ccfde0bb6a874c353c0cdca0fa0ca76c5cca3
PKG_MIRROR_HASH:=fe525cfb71f32ea97156f74009554319610172c2cb6ebe10cdca795586e41596

include $(INCLUDE_DIR)/package.mk
 
define Package/tcpser
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=Hayes modem emulator application
  URL:=https://github.com/go4retro/tcpser
endef
 
define Package/description
  TCPSER turns a PC serial port into an emulated Hayes compatible modem that
  uses TCP/IP for incoming and outgoing connections. It can be used to allow
  older applications and systems designed for modem use to operate on the Internet.
  TCPSER supports all standard Hayes commands, and understands extended and
  vendor proprietary commands (though it does not implement many of them).
  TCPSER can be used for both inbound and outbound connections.
endef
 
define Package/tcpser/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/tcpser $(1)/usr/bin/
endef
 
$(eval $(call BuildPackage,tcpser))
