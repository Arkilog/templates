#!/bin/bash
function isUpToDate(){
    EXPECTED_MSG="Status: Image is up to date for $APP_IMAGE_URL"
    OUTPUT=$(docker pull $APP_IMAGE_URL | grep "$EXPECTED_MSG" | wc -l)
    if [ "$OUTPUT" == "1" ]; then
        echo "Image [$APP_IMAGE_URL] is up to date"; return 0;
    else
        echo "+++++++++++++++++++++++++++++++++++++++++"
        echo "New version of [$APP_IMAGE_URL] is available"
        echo "+++++++++++++++++++++++++++++++++++++++++"; return 1;
    fi
}
export -f isUpToDate
function updateAll(){
    echo "Checking if registry is reacheable..."
    if eval "\$(AWS_DEFAULT_REGION=$APP_REGION aws ecr get-login --no-include-email)" ; then
        echo "Checking registry for updates..."
        isUpToDate || /home/ec2-user/update.sh
    else
        echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
        echo "ERROR Checking registry for updates, will try later"
        echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    fi
}
echo "Checking for updates..."
updateAll
