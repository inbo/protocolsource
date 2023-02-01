#!/bin/sh -l

echo '\nGetting the code...\n'
git clone --quiet https://$INPUT_PAT@github.com/$GITHUB_REPOSITORY /render
cd /render
git checkout main
git config --global user.email "info@inbo.be"
git config --global user.name "INBO"

rm .Rprofile

echo '\nSession info\n'
Rscript -e 'sessioninfo::session_info()'

echo '\nAdd tag to merge commit protocolsource...\n'
echo 'GitHub actions:' $GITHUB_ACTIONS
echo 'Event name:' $GITHUB_EVENT_NAME
echo 'RECENT_MERGED_BRANCH_NAME:' $RECENT_MERGED_BRANCH_NAME
git rev-parse --abbrev-ref origin/HEAD | sed 's/origin\///' | xargs git checkout
Rscript --no-save --no-restore -e 'protocolhelper:::set_tags("'$RECENT_MERGED_BRANCH_NAME'")'
git push --follow-tags

# look up tag names and tag messages to push to repo protocols later
# (not possible to run set_tags() when not in protocolsource anymore)
TAGNAME_GENERAL=$(git tag -l protocols-* --points-at)
TAGNAME_SPECIFIC=$(git tag -l s*p* --points-at)
TAGMESSAGE_GENERAL=$(git for-each-ref refs/tags/$TAGNAME_GENERAL --format='%(contents)')
TAGMESSAGE_SPECIFIC=$(git for-each-ref refs/tags/$TAGNAME_SPECIFIC --format='%(contents)')

# (added for debugging reasons)
echo 'tagname general:' $TAGNAME_GENERAL
echo 'tag message general:' $TAGMESSAGE_GENERAL
echo 'tagname specific:' $TAGNAME_SPECIFIC
echo 'tag message specific:' $TAGMESSAGE_SPECIFIC

echo 'Getting previously published protocols\n'
git clone --quiet --depth=1 --single-branch --branch=main https://$INPUT_PAT@github.com/$GITHUB_REPOSITORY_DEST /destiny
mkdir /render/publish/
cp -R /destiny/. /render/publish/.

echo 'Rendering the Rmarkdown files...\n'
Rscript -e "protocolhelper:::render_release()"
if [ $? -ne 0 ]; then
  echo '\nRendering failed. Please check the error message above.\n';
  exit 1
else
  echo '\nAll Rmarkdown files rendered successfully\n'
fi

echo 'Publishing the rendered files...\n'
cp -R /render/publish/. /destiny/.
cd /destiny
ls -a

git config user.name
git config user.email
git add --all
git commit --message="Add new protocol"
git push -f https://$PAT@github.com/$GITHUB_REPOSITORY_DEST

git rev-parse --abbrev-ref origin/HEAD | sed 's/origin\///' | xargs git checkout
git tag -a $TAGNAME_GENERAL -m "$TAGMESSAGE_GENERAL"
git tag -a $TAGNAME_SPECIFIC -m "$TAGMESSAGE_SPECIFIC"
git push --follow-tags

echo '\nNew version published...'
