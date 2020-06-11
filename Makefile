INSTALL_TARGET_PROCESSES = zaka

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = funintendo

funintendo_FILES = Tweak.x
funintendo_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
