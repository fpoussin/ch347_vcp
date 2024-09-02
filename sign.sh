#!/bin/bash

SIGNING_HASH_ALGO="sha512"
SIGNING_PRIVATE_KEY="/var/lib/shim-signed/mok/MOK.priv"
SIGNING_PUBLIC_KEY="/var/lib/shim-signed/mok/MOK.der"
SIGNING_SCRIPT_DIR="/usr/src/linux-headers-$(uname -r)"
SIGNING_SCRIPT="./scripts/sign-file"

KERNEL_MODULES=(
  "${PWD}/gpio-ch347.ko"
  "${PWD}/i2c-ch347.ko"
  "${PWD}/mfd-ch347.ko"
  "${PWD}/spi-ch347.ko"
)

for mod in "${KERNEL_MODULES[@]}"; do
  echo "signing tainted kernel module $mod"
  (
    cd $SIGNING_SCRIPT_DIR
    $SIGNING_SCRIPT $SIGNING_HASH_ALGO $SIGNING_PRIVATE_KEY $SIGNING_PUBLIC_KEY $mod
  )
done
