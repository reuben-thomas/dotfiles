#!/usr/bin/env bash

set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 FILE.md" >&2
  exit 1
fi

input_file=$1

if [[ ! -f "$input_file" ]]; then
  echo "Error: file not found: $input_file" >&2
  exit 1
fi

output_file=${input_file%.*}.pdf

font_size=13pt
line_height=13pt

header_includes=$(
  cat <<EOF
\\AtBeginDocument{\\fontsize{$font_size}{$line_height}\\selectfont}
EOF
)

pandoc "$input_file" \
  --pdf-engine=tectonic \
  -V geometry:margin=0.5in \
  -V header-includes="$header_includes" \
  -o "$output_file"

echo "Wrote $output_file"
