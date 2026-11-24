#!/bin/bash
. /etc/os-release
echo "$(hostname) · $PRETTY_NAME · $(uname -r)"
