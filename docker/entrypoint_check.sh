#!/bin/sh -l

echo '\nGetting the code...\n'
git clone --quiet https://$PAT@github.com/$GITHUB_REPOSITORY check
cd check
git checkout $GITHUB_HEAD_REF
rm .Rprofile

echo '\nSession info\n'
Rscript -e 'sessioninfo::session_info()'

echo '\nCheck if only protocol is updated...\n'
FOLDERNAME=$(Rscript -e 'cat(protocolhelper::get_path_to_protocol("'$GITHUB_HEAD_REF'"))')
FOLDERNAME_REL=${FOLDERNAME#/github/workspace/check/}
echo 'FOLDERNAME=' $FOLDERNAME
echo 'FOLDERNAME_REL=' $FOLDERNAME_REL
CHANGED=$(git diff --name-only main | grep -v NEWS\.md | grep -v \.zenodo\.json | grep -v \.Rprofile | grep -v ^$FOLDERNAME_REL/)

if [ -n "${CHANGED}" ]; then
  echo '\nBranch '$GITHUB_HEAD_REF' contains changes to files which do not belong to protocol '$GITHUB_HEAD_REF', and these changes will not be passed to the website. Please remove these changes from this branch and start a new branch for changes to other protocols. Changes to be removed:' $CHANGED
  exit 1
fi

echo '\nUpdate version number...\n'
git config --global user.email "info@inbo.be"
git config --global user.name "INBO"
UPDATED=$(Rscript -e 'protocolhelper::update_version_number("'$GITHUB_HEAD_REF'")')
echo 'output updated:' $UPDATED
if [ "$UPDATED" = "[1] TRUE" ]; then
  git push -f
  echo '\ncommit with new version pushed\n'
fi

echo '\nChecking protocols specific tests...\n'

Rscript "docker/check_all.R"
if [ $? -ne 0 ]; then
  echo '\nThe source code failed some checks. Please check the error message above.\n';
  exit 1
fi
