#!/usr/bin/env sh

if [ $# -gt 0 ]; then
  dst="$1"
  shift
else
  dst='origin'
fi

git push -f "$dst" 'conflict0' 'conflict1' 'conflict2'
