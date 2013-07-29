#!/bin/sh # -*- coding: utf-8 mode: shell-script -*-
develop="./heroku/public/js/develop"
rm -fr   ${develop}
mkdir -p ${develop}  && \
cd ${develop} && \
ln -s ../../../../dist/libs.js
ln -s ../../../../lib/prettify.js
