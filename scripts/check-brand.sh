#!/usr/bin/env bash
# Fails if the official BILA logo differs from the checksum recorded in scripts/brand.sha256.
# To replace the logo on purpose: copy the new official file in, then run
#   sha256sum apps/dashboard/public/brand/bila-logo-official.jpeg > scripts/brand.sha256
# and record the change in docs/BRAND.md.
set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")/.."
sha256sum -c scripts/brand.sha256
echo "OK: official logo is unchanged."
