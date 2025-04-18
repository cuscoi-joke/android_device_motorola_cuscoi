#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/motorola/cuscoi
DLKM_MODULES_PATH := $(DEVICE_PATH)-kernel/vendor-modules
RAMDISK_MODULES_PATH := $(DEVICE_PATH)-kernel/ramdisk-modules

# Inherit from motorola sm6450-common
include device/motorola/sm6450-common/BoardConfigCommon.mk

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := cuscoi

# Fingerprint
SOONG_CONFIG_qtidisplay_udfps := true

# HIDL
DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE += $(DEVICE_PATH)/device_framework_matrix.xml
DEVICE_MANIFEST_FILE += $(DEVICE_PATH)/manifest.xml
ODM_MANIFEST_SKUS += b d
ODM_MANIFEST_B_FILES := $(DEVICE_PATH)/sku/manifest_b.xml
ODM_MANIFEST_D_FILES := $(DEVICE_PATH)/sku/manifest_d.xml

# Kernel
BOARD_KERNEL_CMDLINE += androidboot.hab.product=cuscoi
#TARGET_KERNEL_CONFIG += vendor/lineage_cuscoi.config

# Kernel Modules
#BOARD_VENDOR_KERNEL_MODULES_LOAD := $(strip $(shell cat $(DEVICE_PATH)/modules.load))
#BOARD_VENDOR_KERNEL_MODULES_BLOCKLIST_FILE := $(DEVICE_PATH)/modules.blocklist
#BOARD_VENDOR_RAMDISK_RECOVERY_KERNEL_MODULES_LOAD := $(strip $(shell cat $(DEVICE_PATH)/modules.load.recovery))
#BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD := $(strip $(shell cat $(DEVICE_PATH)/modules.load.ramdisk))
#BOOT_KERNEL_MODULES := $(BOARD_VENDOR_RAMDISK_RECOVERY_KERNEL_MODULES_LOAD)

BOARD_VENDOR_RAMDISK_KERNEL_MODULES := $(wildcard $(RAMDISK_MODULES_PATH)/*.ko)
BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD := $(patsubst %,$(RAMDISK_MODULES_PATH)/%,$(shell cat $(RAMDISK_MODULES_PATH)/modules.load))
BOARD_VENDOR_RAMDISK_RECOVERY_KERNEL_MODULES_LOAD  := $(patsubst %,$(RAMDISK_MODULES_PATH)/%,$(shell cat $(RAMDISK_MODULES_PATH)/modules.load.recovery))
BOARD_VENDOR_RAMDISK_KERNEL_MODULES_BLOCKLIST_FILE := $(RAMDISK_MODULES_PATH)/modules.blocklist

BOARD_VENDOR_KERNEL_MODULES := $(wildcard $(DLKM_MODULES_PATH)/*.ko)
BOARD_VENDOR_KERNEL_MODULES_LOAD := $(patsubst %,$(DLKM_MODULES_PATH)/%,$(shell cat $(DLKM_MODULES_PATH)/modules.load))
BOARD_VENDOR_KERNEL_MODULES_BLOCKLIST_FILE := $(DLKM_MODULES_PATH)/modules.blocklist

# Prebuilt Kernel
TARGET_FORCE_PREBUILT_KERNEL := true
TARGET_NO_KERNEL_OVERRIDE := true
TARGET_NO_KERNEL := false
BOARD_KERNEL_BINARIES := kernel
TARGET_KERNEL_VERSION := 5.10
TARGET_KERNEL_SOURCE := $(DEVICE_PATH)-kernel/kernel-headers
TARGET_PREBUILT_DTB := $(DEVICE_PATH)-kernel/dtb.img
BOARD_PREBUILT_DTBOIMAGE := $(DEVICE_PATH)-kernel/dtbo.img
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)-kernel/kernel
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)-kernel/dtb.img:$(TARGET_COPY_OUT)/dtb.img \
    $(DEVICE_PATH)-kernel/kernel:kernel

# Partitions
BOARD_MOT_DP_GROUP_SIZE := 8313110528 # ( BOARD_SUPER_PARTITION_SIZE - 4MB )
BOARD_SUPER_PARTITION_SIZE := 8317304832

# Properties
TARGET_PRODUCT_PROP += $(DEVICE_PATH)/product.prop
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop

# Recovery
TARGET_RECOVERY_UI_MARGIN_HEIGHT := 90

# Security
BOOT_SECURITY_PATCH := 2025-01-01
VENDOR_SECURITY_PATCH := $(BOOT_SECURITY_PATCH)

# Verified Boot
BOARD_AVB_ROLLBACK_INDEX := 13
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX := 13

# inherit from the proprietary version
include vendor/motorola/cuscoi/BoardConfigVendor.mk
