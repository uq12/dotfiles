#!/data/data/com.termux/files/usr/bin/bash

PATH_DIR="$PREFIX/bin"
# mkdir -p "$PATH_DIR"
curl https://cht.sh/:cht.sh > "$PATH_DIR/cht.sh"
chmod +x "$PATH_DIR/cht.sh"
