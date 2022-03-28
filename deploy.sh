#!/usr/bin/env bash

git push -D origin gh-pages
git branch -D gh-pages
git checkout --orphan gh-pages
git rm -rf .
cp -a notes/build docs/
git add docs
git commit -m "Init"
