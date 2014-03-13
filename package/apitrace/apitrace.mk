################################################################################
#
# apitrace
#
################################################################################

APITRACE_VERSION = c181b7fbf4b1c3912424761fec8ac7124640543a
APITRACE_SITE = $(call github,apitrace,apitrace,$(APITRACE_VERSION))
APITRACE_LICENSE = MIT
APITRACE_LICENSE_FILES = LICENSE

APITRACE_DEPENDENCIES = host-python

ifeq ($(BR2_PACKAGE_XLIB_LIBX11), y)
APITRACE_DEPENDENCIES += xlib_libX11
endif

# Gui was never tested, so we prefer to explicitly disable it
APITRACE_CONF_OPT += -DENABLE_GUI=false

$(eval $(cmake-package))
