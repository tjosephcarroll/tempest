#!/bin/bash
# Loader for Developer Experience Server Side Code
main(){
    local url valid directory
    url=$(prompt $1)
    printf "\nValidating...\n"
    valid=$(validate_before_load $url)
    if [ "$valid" = "0" ]
    then
        printf "\nLoading...\n"
        load $url $2
    else
        printf "\nValidation Error: $valid"
        printf "\n\n"
    fi
    printf "\nCompleted.\n"
}

prompt(){
    if [ "$1" != "" ]
    then
        echo "$1"
    else
        local url
        #Prompts for full git repo url (https included)
        printf "\n"
        read -r -p "Enter git repo url: " url
        echo "$url"
    fi
}
validate_before_load(){
    # Validate Before Load
        # check repo link is real
        # check for try-iris
    # Returns 0 if everything is good. Otherwise returns a message to output.
    local result url
    url=$1

 
    # checks if the repo is public and valid, and that the container exists
    git ls-remote $url -q &> /dev/null
    if [ $? != 0 ];
    then
        result="url provided is not a valid repository"
    #does the IRIS container exist?
    elif [ ! "$(sudo docker ps -q -f name=try-iris)" ]
    then
        result="no container named try-iris"
    else
        result=0
    fi
    echo "$result"
}
load(){
    # Run the loader
        # Git clone on the repo into a random named directory, which is cleaned up after load.
        # Change permissions so that we can execute
        # Run the shell script named load.sh in the top level of the repo
        # the rest is the responsibility of the repository
    #
    local directory url
    url=$1
    #get the directory where the bash script lives and add a random numbered new dir
    dir1="/tmp"
    dir2=$(($(od -An -N1 -tu1 /dev/urandom)))
    directory="$dir1/$dir2"
    
    #get the code and set permissions
    sudo git clone -q $url $directory
    sudo chmod -R 775 $directory

    #run the repo specific code
    sudo $directory/load.sh

    if [ "$2" = "test" ]
        then
            exit
        else
            clean_up $directory
    fi
}

clean_up(){
    # Clean Up
    local directory
    directory=$1
    sudo rm -r $directory
}

main $1 $2