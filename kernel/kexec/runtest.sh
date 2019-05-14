#!/usr/bin/env sh
#
# Copyright 2019 Red Hat, Inc.
#
# SPDX-License-Identifier: GPL-3.0-or-later
#

readonly BOOT="/boot"


# check the execution environment
if [ -z ${RSTRNT_REBOOTCOUNT} ]; then
  printf "This script has to be run by the restraint test harness.\n" >&2
  false

# the first boot of the system
elif [ ${RSTRNT_REBOOTCOUNT} -eq 0 ]; then
  kernel_release=$(uname --kernel-release)
  kexec --initrd=${BOOT}/initramfs-${kernel_release}.img \
        --reuse-cmdline \
        ${BOOT}/vmlinuz-${kernel_release}

# already rebooted
else
  true
fi

exit $?
