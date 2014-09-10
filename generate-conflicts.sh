#!/usr/bin/env bash

./cleanup.sh
git checkout 'conflict'
git branch -D 'conflict0'  'conflict1' 'conflict2'

for i in '0' '1' '2'; do

  if [ "${i}" = '0' ]; then
    git checkout -b "conflict${i}"
    echo "${i}" > 'file-dir'
    echo "${i}" > 'file-sym'
    echo "${i}" > 'text-to-binary-preview.png'
    echo "${i}" > 'text-to-binary-no-preview'
  else
    if [ "${i}" = '1' ]; then
      git checkout -b "conflict${i}" 'conflict0'
      echo "${i}" > 'file-dir'
      echo "${i}" > 'file-dir-nobase'
      echo "${i}" > 'file-sym'
      echo "${i}" > 'file-sym-nobase'
      echo "${i}" > 'text-to-binary-preview.png'
      echo "${i}" > 'text-to-binary-no-preview'
    else
      git checkout -b "conflict${i}" 'conflict0'
      rm 'file-dir'
      mkdir 'file-dir'
      touch 'file-dir/.keep'
      mkdir 'file-dir-nobase'
      touch 'file-dir-nobase/.keep'
      ln -fs 'nobase' 'file-sym'
      ln -s 'nobase' 'file-sym-nobase'
      cp 'binary-preview0.png' 'text-to-binary-preview.png'
      printf '\0' > 'text-to-binary-no-preview'
    fi
    echo "${i}" > 'nobase'
    echo "${i}" > 'nobase-same'
  fi

  printf 'a\0%s\0c\0' "${i}" > 'binary-no-preview'
  cp "binary-preview${i}.png" 'binary-preview.png'

  printf "\
# One change at end.
a = 0; b = 0; c = 0; d = 0; e = 0; f = 0; g = 0; h = 0; i = 0; j = 0; k = 0; l = 0; m = 0; n = 0; o = 0; p = 0; r = 0; s = 0; t = 0; u = 0; v = 0; w = 0; x = 0; y = ${i}; z = 0;




# Two changes.
a = 0; b = ${i}; c = 0; d = 0; e = 0; f = 0; g = 0; h = 0; i = 0; j = 0; k = 0; l = 0; m = 0; n = 0; o = 0; p = 0; r = 0; s = 0; t = 0; u = 0; v = 0; w = 0; x = 0; y = ${i}; z = 0;




# Three changes.
a = 0; b = ${i}; c = 0; d = 0; e = 0; f = 0; g = 0; h = 0; i = 0; j = 0; k = 0; l = ${i}; m = 0; n = 0; o = 0; p = 0; r = 0; s = 0; t = 0; u = 0; v = 0; w = 0; x = 0; y = ${i}; z = 0;




# Medium width.
a = 0; b = 0; c = 0; d = 0; e = 0; f = 0; g = 0; h = 0; i = 0; j = 0; k = 0; l = ${i}; m = 0;
" > 'long-line.rb'

  printf "\
a 0 0 0
b 0 0 0
c 0 0 0
d ${i} 0 ${i}
e 0 0 0
f 0 0 0
g 0 0 0
h 0 0 0

i 0 0 0
j 0 0 0
k 0 0 0
l 0 0 0
m ${i} 0 ${i}
n 0 0 0
o 0 0 0
p 0 0 0
" > 'md.md'

  printf "\
# Multi multi add.
a = 0
b = 0
c = 0
$( if [ ! "${i}" = '0' ]; then echo "\
d = ${i}
e = ${i}"; fi )
f = 0
g = 0
h = 0

# One multi add.
a = 0
b = 0
c = 0
$(
if [ ! "${i}" = '0' ]; then
  echo "d = ${i}"
  if [ "${i}" = '2' ]; then
    echo "e = ${i}";
  fi
fi )
f = 0
g = 0
h = 0

# Multi multi modify.
a = 0
b = 0
c = 0
d = ${i}
e = ${i}
f = 0
g = 0
h = 0

# One multi modify.
a = 0
b = 0
c = 0
$(
if [ "${i}" = '1' ]; then
  echo "d = 0"
else
  echo "d = ${i}"
fi )
e = ${i}
f = 0
g = 0
h = 0
" > 'multiline.rb'

  printf "\
a = 0
b = 0
c = 0
d = ${i}
e = 0
f = 0
g = 0
h = 0
i = 0
j = 0
k = 0
l = 0
m = ${i}
n = 0
o = 0
p = 0
" > 'no-overlap.rb'

  printf "\
a = 0
b = ${i}
c = 0
d = 0
e = 0
f = 0
g = ${i}
h = 0
" > 'overlap.rb'

  # Bash extension
  rm -f 'many-lines'
  for c in {A..Z} {a..z}; do
    echo "${c} = ${i}" >> 'many-lines'
  done

  git add '.'
  git commit -m "${i}"
done
