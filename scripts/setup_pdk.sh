#!/usr/bin/env bash
set -euo pipefail
export PDK_ROOT="${PDK_ROOT:-$HOME/pdks}"
export PDK="${PDK:-sky130A}"
mkdir -p "$PDK_ROOT"
cd "$(dirname "$0")/../third_party/open_pdks"
git submodule update --init --recursive || true
./configure --enable-sky130-pdk --with-sky130-variants=all --prefix="$PDK_ROOT"
make -j"$(nproc)"
make install
echo "Installed $PDK in $PDK_ROOT/$PDK"
echo 'Add to your shell: export PDK_ROOT="'"$PDK_ROOT"'" ; export PDK="'"$PDK"'"'
