#!/bin/bash
#exec's into the container and does an IRIS list
main(){
    if [ "$(sudo docker ps -a | grep try-iris)" ]
    then
        printf "\nThe InterSystems IRIS container is running:\n"
        sudo docker exec -it try-iris iris list
        printf "\n"
    else
        printf "\nThere is no running container named try-iris\n"
    fi
}
main