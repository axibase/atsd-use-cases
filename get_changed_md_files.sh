if [ -z $TRAVIS_PULL_REQUEST_BRANCH ]
then
    find . -name \*.md -print
else
    git diff --name-only HEAD...$TRAVIS_PULL_REQUEST_BRANCH | grep "\.md$"
fi