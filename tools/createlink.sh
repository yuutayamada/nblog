#!/bin/sh # -*- coding: utf-8 mode: shell-script -*-
develop="./heroku/public/js/develop"
mkdir -p ${develop}  && \
cd ${develop} && \
ln -s ../../../../templates/article.js
ln -s ../../../../templates/coderwall.js
ln -s ../../../../templates/twitter.js
ln -s ../../../../templates/user.js
ln -s ../../../../router.js
