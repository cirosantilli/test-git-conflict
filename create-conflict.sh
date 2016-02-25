#!/bin/bash
#mkdir git-repo
#cd git-repo
#git init
touch tara_code.sh
git add tara_code.sh
echo "echo Hello" > tara_code.sh
git commit -am 'initial'
git checkout -b tara_branch
echo "echo \"Hello World\"" > tara_code.sh
git commit -am 'first commit on tara_branch'
git checkout master
echo "echo \"Hello World!\"" > tara_code.sh
git commit -am 'second commit on master'
git merge tara_branch
