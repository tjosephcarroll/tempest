#!/bin/bash
#sets the kit, branch, and image names
#In the automation pipeline this is what we change/config
#depending on provider, branch, and application version
main(){
    export KIT=iris-2019.1.0S.111.0-docker.tar.gz
    export BRANCH=master
    export IMAGE='intersystems/iris:2019.1.0S.111.0'
}

main