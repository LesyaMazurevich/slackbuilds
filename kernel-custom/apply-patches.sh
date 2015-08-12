#!/bin/sh

set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# Set to test (some patches require others, so, is not 100%)
PATCH_DRYRUN=${PATCH_DRYRUN:-NO}

unset PATCH_DRYRUN_OPT PATCH_VERBOSE_OPT

[ "${PATCH_DRYRUN}" = "YES" ] && PATCH_DRYRUN_OPT="--dry-run"
[ "${PATCH_VERBOSE}" = "YES" ] && PATCH_VERBOSE_OPT="--verbose"
[ "${PATCH_SVERBOSE}" = "YES" ] && set -o xtrace

PATCHCOM="patch ${PATCH_DRYRUN_OPT} -p1 -F1 -s ${PATCH_VERBOSE_OPT}"

ApplyPatch() {
  local patch=$1
  shift
  if [ ! -f ${SB_PATCHDIR}/${patch} ]; then
    exit 1
  fi
  echo "Applying ${patch}"
  case "${patch}" in
  *.bz2) bzcat "${SB_PATCHDIR}/${patch}" | ${PATCHCOM} ${1+"$@"} ;;
  *.gz) zcat "${SB_PATCHDIR}/${patch}" | ${PATCHCOM} ${1+"$@"} ;;
  *) ${PATCHCOM} ${1+"$@"} -i "${SB_PATCHDIR}/${patch}" ;;
  esac
}

ApplyOptionalPatch() {
  local patch=$1
  shift
  if [ ! -f ${SB_PATCHDIR}/${patch} ]; then
    exit 1
  fi
  case "${patch}" in
  *.bz2) local C=$(bzcat ${SB_PATCHDIR}/${patch} | wc -l | awk '{print $1}') ;;
  *.gz) local C=$(zcat ${SB_PATCHDIR}/${patch} | wc -l | awk '{print $1}') ;;
  *) local C=$(wc -l ${SB_PATCHDIR}/${patch} | awk '{print $1}') ;;
  esac
  if [ "${C}" -gt 9 ]; then
    ApplyPatch ${patch} ${1+"$@"}
  fi
}

# Most patches are retrieved from Fedora git repository

ApplyPatch kbuild-AFTER_LINK.patch

#
# misc small stuff to make things compile
#
ApplyOptionalPatch compile-fixes.patch.gz

# revert patches from upstream that conflict or that we get via other means
ApplyOptionalPatch upstream-reverts.patch -R

ApplyOptionalPatch hotfixes.patch

# vm patches
ApplyPatch mm-Fix-assertion-mapping-nrpages-0-in-end_writeback.patch

# mm patches

# Architecture patches
# x86(-64)
# Add K10 and native cpu optimization support
ApplyPatch add-cpu-optimizations.patch

ApplyPatch x86_64-hpet-64bit-timer.patch

ApplyPatch lib-cpumask-Make-CPUMASK_OFFSTACK-usable-without-deb.patch

#
# Intel IOMMU
#

#
# bugfixes to drivers and filesystems
#

# reisefs

# ext4

# ext3

# xfs

# btrfs

# cifs

# NFSv4

# USB

# WMI

# ACPI
ApplyPatch Revert-Revert-ACPI-video-change-acpi-video-brightnes.patch

# cpufreq
#ApplyPatch cpufreq_ondemand_performance_optimise_default_settings.patch

#
# PCI
#

#
# SCSI / block Bits.
#

# BFQ disk scheduler - http://algo.ing.unimo.it/people/paolo/disk_sched/
mkdir -p bfq_patches
for file in ${BFQSRCARCHIVES} ;do
  cp ${BFQDOWNDIR}/${file} bfq_patches/
done

( SB_PATCHDIR=bfq_patches
  for file in ${BFQSRCARCHIVES} ;do
    ApplyPatch ${file}
  done
)
ApplyPatch make-bfq-the-default-io-scheduler.patch

# ALSA

# block/bio
#

# Networking

# Misc fixes
# The input layer spews crap no-one cares about.
ApplyPatch input-kill-stupid-messages.patch

# stop floppy.ko from autoloading during udev...
ApplyPatch die-floppy-die.patch

ApplyPatch no-pcspkr-modalias.patch

# Silence some useless messages that still get printed with 'quiet'
ApplyPatch input-silence-i8042-noise.patch

# Make fbcon not show the penguins with 'quiet'
ApplyPatch silence-fbcon-logo.patch

# Changes to upstream defaults.

# libata

#
# VM related fixes.
#

# /dev/crash driver.
ApplyPatch crash-driver.patch

# crypto/

# DRM core

# Nouveau DRM

# Intel DRM
ApplyPatch drm-i915-hush-check-crtc-state.patch

# Patches headed upstream
ApplyPatch disable-i8042-check-on-apple-mac.patch

ApplyPatch lis3-improve-handling-of-null-rate.patch

# Disable watchdog on virtual machines.
ApplyPatch watchdog-Disable-watchdog-on-virtual-machines.patch

#rhbz 754518
ApplyPatch scsi-sd_revalidate_disk-prevent-NULL-ptr-deref.patch

#ApplyPatch weird-root-dentry-name-debug.patch

# https://fedoraproject.org/wiki/Features/Checkpoint_Restore
ApplyPatch criu-no-expert.patch

#CVE-2015-2150 rhbz 1196266 1200397
ApplyPatch xen-pciback-Don-t-disable-PCI_COMMAND-on-PCI-device-.patch

#rhbz 1212230
ApplyPatch Input-synaptics-pin-3-touches-when-the-firmware-repo.patch

#rhbz 1133378
ApplyPatch firmware-Drop-WARN-from-usermodehelper_read_trylock-.patch

#rhbz 1226743
ApplyPatch drm-i915-turn-off-wc-mmaps.patch

# CVE-2015-XXXX rhbz 1230770 1230774
ApplyPatch kvm-x86-fix-kvm_apic_has_events-to-check-for-NULL-po.patch

#rhbz 1227891
ApplyPatch HID-rmi-Disable-populating-F30-when-the-touchpad-has.patch

# rhbz 1180920 1206724
ApplyPatch pcmcia-fix-a-boot-time-warning-in-pcmcia-cs-code.patch

# CVE-2015-3290 CVE-2015-3291 rhbz 1243465 1245927
ApplyPatch x86-asm-entry-64-Remove-pointless-jump-to-irq_return.patch
ApplyPatch x86-entry-Stop-using-PER_CPU_VAR-kernel_stack.patch
ApplyPatch x86-entry-Define-cpu_current_top_of_stack-for-64-bit.patch
ApplyPatch x86-nmi-Enable-nested-do_nmi-handling-for-64-bit-ker.patch
ApplyPatch x86-nmi-64-Remove-asm-code-that-saves-cr2.patch
ApplyPatch x86-nmi-64-Switch-stacks-on-userspace-NMI-entry.patch
ApplyPatch x86-nmi-64-Improve-nested-NMI-comments.patch
ApplyPatch x86-nmi-64-Reorder-nested-NMI-checks.patch
ApplyPatch x86-nmi-64-Use-DF-to-avoid-userspace-RSP-confusing-n.patch

# CVE-2015-5697 (rhbz 1249011 1249013)
ApplyPatch md-use-kzalloc-when-bitmap-is-disabled.patch

#rhbz 1251877 1251880 1250279 1248741
ApplyPatch HID-hid-input-Fix-accessing-freed-memory-during-devi.patch

# By Alon Bar-Lev <alon.barlev <at> gmail.com>
#ApplyPatch ps3-control-ep.patch

unset DRYRUN DRYRUN_OPT VERBOSE VERBOSE_OPT SVERBOSE

set +e +o pipefail +o xtrace
