#!/bin/bash
binary_path="$1"
if [[ -z "$binary_path" ]]; then
  echo "Usage: create_desktop_entry <path-to-binary>"
  exit 1
fi
if [[ ! -f "$binary_path" ]]; then
  echo "Error: File not found: $binary_path"
  exit 1
fi
bin_name=$(basename "$binary_path")
bin_dir="$HOME/.local/bin"
desktop_dir="$HOME/.local/share/applications"
desktop_file="$bin_name.desktop"

mkdir -p "$bin_dir" "$desktop_dir"

cp "$binary_path" "$bin_dir/$bin_name"
chmod +x "$bin_dir/$bin_name"
cat >"$desktop_dir/$desktop_file" <<EOF
[Desktop Entry]
Type=Application
Name=$bin_name
Exec=$bin_dir/$bin_name
EOF
echo "✓ Binary moved to: $bin_dir/$bin_name"
echo "✓ Desktop entry created: $desktop_dir/$desktop_file"
