#!/bin/bash

current_mode=$(makoctl mode)
if [ "$current_mode" == "dnd" ]; then
  echo "status|bool|dnd"
else
  echo "status|bool|default"
fi

echo ""
