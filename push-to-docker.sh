#!/bin/bash

set -ev

if [[ $TRAVIS_PULL_REQUEST == "false" ]] && [[ $TRAVIS_BRANCH == "master" ]]; then
    docker tag $REPO:$TAG $REPO:$TRAVIS_BUILD_NUMBER;
    docker push $REPO:$TRAVIS_BUILD_NUMBER;
fi

docker push $REPO:$TAG