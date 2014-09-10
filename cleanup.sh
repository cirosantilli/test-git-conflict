#!/usr/bin/env sh

git merge --abort
git reset --hard
git clean -df
# TODO why is this needed?
git reset --hard
