if [ -z $TRAVIS_PULL_REQUEST_BRANCH ]
then
    find . -name \*.md -print
else
    git diff --name-only $(git merge-base HEAD master) | grep "\.md$"
fi