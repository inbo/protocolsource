#!/bin/sh -l

echo '\nGetting the code...\n'
git clone --branch=$BRANCH_SOURCE https://$INPUT_TOKEN@github.com/$GITHUB_REPOSITORY /update
git config --global user.email "info@inbo.be"
git config --global user.name "INBO"
cd /update

rm .Rprofile

echo '\nSession info\n'
Rscript -e 'sessioninfo::session_info()'

echo '\nUpdating zenodo...\n'
Rscript --no-save --no-restore -e 'protocolhelper:::update_zenodo()'
git add .zenodo.json
git commit --message="update .zenodo.json"

echo '\nUpdating general NEWS.md...\n'
Rscript --no-save --no-restore -e 'protocolhelper:::update_news_release("'$PROTOCOL_CODE'")'
git add NEWS.md
git commit --message="update general NEWS.md"

echo 'git push'
git push -f
