#!/bin/bash
# -*- ENCODING: UTF-8 -*-

git remote set-url origin https://github.com/HCarlos/Arji-iOS.git
git config --global user.email "r0@tecnointel.mx"
git config --global user.name "HCarlos"
git config --global color.ui true
git config core.fileMode false
git config --global push.default simple

git checkout master

git status

git add .

git commit -m "Actualizado al 23-03-2016."

git push -u origin master --force

exit
