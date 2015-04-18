################################################################################
#
# WPE
#
################################################################################

WPE_VERSION = a2caf0503fa204a16549da47444305d0dbefc36f
WPE_SITE = $(call github,Metrological,WebKitForWayland,$(WPE_VERSION))

WPE_INSTALL_STAGING = YES
WPE_DEPENDENCIES = host-flex host-bison host-gperf host-ruby host-ninja \
	host-pkgconf zlib pcre libgles libegl cairo freetype fontconfig \
	harfbuzz icu libxml2 libxslt sqlite libsoup jpeg webp wayland

WPE_FLAGS = \
		-DENABLE_ACCELERATED_2D_CANVAS=ON \
		-DENABLE_BATTERY_STATUS=OFF \
		-DENABLE_CANVAS_PATH=ON \
		-DENABLE_CANVAS_PROXY=OFF \
		-DENABLE_CHANNEL_MESSAGING=ON \
		-DENABLE_CSP_NEXT=OFF \
		-DENABLE_CSS3_CONDITIONAL_RULES=ON \
		-DENABLE_CSS3_TEXT=OFF \
		-DENABLE_CSS3_TEXT_LINE_BREAK=OFF \
		-DENABLE_CSS_BOX_DECORATION_BREAK=ON \
		-DENABLE_CSS_COMPOSITING=OFF \
		-DENABLE_CSS_DEVICE_ADAPTATION=OFF \
		-DENABLE_CSS_GRID_LAYOUT=ON \
		-DENABLE_CSS_IMAGE_ORIENTATION=OFF \
		-DENABLE_CSS_IMAGE_RESOLUTION=OFF \
		-DENABLE_CSS_IMAGE_SET=ON \
		-DENABLE_CSS_REGIONS=ON \
		-DENABLE_CSS_SHAPES=ON \
		-DENABLE_CUSTOM_SCHEME_HANDLER=OFF \
		-DENABLE_DATALIST_ELEMENT=OFF \
		-DENABLE_DATA_TRANSFER_ITEMS=OFF \
		-DENABLE_DETAILS_ELEMENT=ON \
		-DENABLE_DEVICE_ORIENTATION=OFF \
		-DENABLE_DOM4_EVENTS_CONSTRUCTOR=OFF \
		-DENABLE_DOWNLOAD_ATTRIBUTE=OFF \
		-DENABLE_ES6_CLASS_SYNTAX=OFF \
		-DENABLE_FONT_LOAD_EVENTS=OFF \
		-DENABLE_FTL_JIT=OFF \
		-DENABLE_FTPDIR=ON \
		-DENABLE_FULLSCREEN_API=OFF \
		-DENABLE_GAMEPAD=OFF \
		-DENABLE_GEOLOCATION=OFF \
		-DENABLE_HIGH_DPI_CANVAS=OFF \
		-DENABLE_ICONDATABASE=ON \
		-DENABLE_INDEXED_DATABASE=OFF \
		-DENABLE_INPUT_SPEECH=OFF \
		-DENABLE_INPUT_TYPE_COLOR=OFF \
		-DENABLE_INPUT_TYPE_DATE=OFF \
		-DENABLE_INPUT_TYPE_DATETIMELOCAL=OFF \
		-DENABLE_INPUT_TYPE_DATETIME_INCOMPLETE=OFF \
		-DENABLE_INPUT_TYPE_MONTH=OFF \
		-DENABLE_INPUT_TYPE_TIME=OFF \
		-DENABLE_INPUT_TYPE_WEEK=OFF \
		-DENABLE_LEGACY_NOTIFICATIONS=OFF \
		-DENABLE_LEGACY_VENDOR_PREFIXES=ON \
		-DENABLE_LINK_PREFETCH=OFF \
		-DENABLE_LLINT_C_LOOP=OFF \
		-DENABLE_MATHML=ON \
		-DENABLE_MEDIA_CAPTURE=OFF \
		-DENABLE_MEDIA_STATISTICS=OFF \
		-DENABLE_METER_ELEMENT=ON \
		-DENABLE_MHTML=OFF \
		-DENABLE_MOUSE_CURSOR_SCALE=OFF \
		-DENABLE_NAVIGATOR_CONTENT_UTILS=ON \
		-DENABLE_NAVIGATOR_HWCONCURRENCY=ON \
		-DENABLE_NETSCAPE_PLUGIN_API=OFF \
		-DENABLE_NOSNIFF=OFF \
		-DENABLE_NOTIFICATIONS=OFF \
		-DENABLE_ORIENTATION_EVENTS=OFF \
		-DENABLE_PERFORMANCE_TIMELINE=ON \
		-DENABLE_PICTURE_SIZES=ON \
		-DENABLE_PROMISES=ON \
		-DENABLE_PROXIMITY_EVENTS=OFF \
		-DENABLE_QUOTA=OFF \
		-DENABLE_REQUEST_ANIMATION_FRAME=ON \
		-DENABLE_RESOLUTION_MEDIA_QUERY=OFF \
		-DENABLE_RESOURCE_TIMING=ON \
		-DENABLE_SCRIPTED_SPEECH=OFF \
		-DENABLE_SECCOMP_FILTERS=OFF \
		-DENABLE_STREAMS_API=ON \
		-DENABLE_SUBTLE_CRYPTO=OFF \
		-DENABLE_SUID_SANDBOX_LINUX=OFF \
		-DENABLE_SVG_FONTS=ON \
		-DENABLE_TEMPLATE_ELEMENT=ON \
		-DENABLE_TEXT_AUTOSIZING=OFF \
		-DENABLE_THREADED_COMPOSITOR=OFF \
		-DENABLE_TOUCH_EVENTS=ON \
		-DENABLE_TOUCH_ICON_LOADING=OFF \
		-DENABLE_TOUCH_SLIDER=OFF \
		-DENABLE_USER_TIMING=ON \
		-DENABLE_VIBRATION=OFF \
		-DENABLE_WEBGL=ON \
		-DENABLE_WEB_REPLAY=OFF \
		-DENABLE_WEB_SOCKETS=ON \
		-DENABLE_WEB_TIMING=ON \
		-DENABLE_XHR_TIMEOUT=ON \
		-DENABLE_XSLT=ON \
		-DUSE_SYSTEM_MALLOC=OFF \
		-DUSE_KEY_INPUT_HANDLING_LINUX_INPUT=ON

ifeq ($(BR2_WPE_GSTREAMER),y)
	WPE_DEPENDENCIES += \
		gstreamer1 gst1-plugins-base gst1-plugins-good gst1-plugins-bad
	WPE_FLAGS += \
		-DENABLE_VIDEO=ON -DENABLE_VIDEO_TRACK=ON
else
	WPE_FLAGS += \
		-DENABLE_VIDEO=OFF -DENABLE_VIDEO_TRACK=OFF
endif

ifeq ($(BR2_PACKAGE_ATHOL),y)
#	WPE_FLAGS += -DUSE_SYSTEM_MALLOC=ON
	WPE_DEPENDENCIES += athol
	WPE_SHELL = Athol
else
	WPE_DEPENDENCIES += weston
	WPE_SHELL = Weston
endif
 
ifeq ($(BR2_ENABLE_DEBUG),y)
	BUILDTYPE = Debug
	WPE_BUILDDIR = $(@D)/debug
	WPE_FLAGS += \
		-DCMAKE_C_FLAGS_DEBUG="-O0 -g -Wno-cast-align" \
		-DCMAKE_CXX_FLAGS_DEBUG="-O0 -g -Wno-cast-align"
else
	BUILDTYPE = Release
	WPE_BUILDDIR = $(@D)/release
	WPE_FLAGS += \
		-DCMAKE_C_FLAGS_RELEASE="-O2 -DNDEBUG -Wno-cast-align" \
		-DCMAKE_CXX_FLAGS_RELEASE="-O2 -DNDEBUG -Wno-cast-align"
endif

ifeq ($(BR2_PACKAGE_WPE_USE_DXDRM_EME),y)
	WPE_FLAGS += -DENABLE_DXDRM=ON
endif

ifeq ($(BR2_PACKAGE_WPE_USE_ENCRYPTED_MEDIA),y)
	WPE_FLAGS += -DENABLE_ENCRYPTED_MEDIA_V2=ON -DENABLE_ENCRYPTED_MEDIA=ON
endif

ifeq ($(BR2_PACKAGE_WPE_USE_MEDIA_SOURCE),y)
	WPE_FLAGS += -DENABLE_MEDIA_SOURCE=ON
endif

ifeq ($(BR2_PACKAGE_WPE_ENABLE_JS_MEMORY_TRACKING),y)
	WPE_FLAGS += -DENABLE_JS_MEMORY_TRACKING=ON
endif

WPE_CONF_OPT = -DPORT=WPE -G Ninja \
	-DCMAKE_BUILD_TYPE=$(BUILDTYPE) \
	$(WPE_FLAGS)

define WPE_BUILD_CMDS
	$(WPE_MAKE_ENV) $(HOST_DIR)/usr/bin/ninja -C $(WPE_BUILDDIR) libWPEWebKit.so WPE{Web,Network}Process WPE$(WPE_SHELL)Shell
endef

define WPE_INSTALL_STAGING_CMDS
	(cd $(WPE_BUILDDIR) && \
	cp bin/WPE{Network,Web}Process $(STAGING_DIR)/usr/bin/ && \
	cp -d lib/libWPE* $(STAGING_DIR)/usr/lib/ )
endef

define WPE_INSTALL_TARGET_CMDS
	(pushd $(WPE_BUILDDIR) > /dev/null && \
	cp bin/WPE{Network,Web}Process $(TARGET_DIR)/usr/bin/ && \
	cp -d lib/libWPE* $(TARGET_DIR)/usr/lib/ && \
	$(STRIPCMD) $(TARGET_DIR)/usr/lib/libWPEWebKit.so.0.0.1 && \
	popd > /dev/null && \
	install -D -m 0755 package/wpe/wpe $(TARGET_DIR)/usr/bin )
endef

RSYNC_VCS_EXCLUSIONS += --exclude LayoutTests --exclude WebKitBuild

$(eval $(cmake-package))
