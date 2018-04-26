if [ $TRAVIS_BRANCH == 'master' ]
then
    find . -name \*.md -print
else
    git diff --name-only HEAD...$TRAVIS_BRANCH | grep "\.md$"
fi