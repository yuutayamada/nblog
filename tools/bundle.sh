#!/bin/sh # -*- coding: utf-8-unix mode: shell-script -*-

movePosts() {
    # skip moving post if it set arg1
    # Use this func when developing
    if ! test $1; then
        mv ./src/*.md ./src/_posted/
    fi
}

node ./tools/convertHtmlFromMd.js
movePosts()
node ./tools/createJson.js
browserify -t coffeeify ./build.coffee > /tmp/bundle.js
