#!/bin/bash
#lists options
main(){
    printf "\n---"
    printf "\nUsage:  iris COMMAND"
    printf "\n"
    printf "\nA wrapper utility for the IRIS Developer Experience"
    printf "\n"
    printf "\nCommands:"
    printf "\n   password   - set the default password for IRIS"
    printf "\n   status     - display status of the IRIS container"
    printf "\n   info       - display the IRIS connection information"
    printf "\n   load       - loads server code for developer experience"
    printf "\n   help       - displays the available commands"
    printf "\n---"
    printf "\nHelpful Docker Commands:"
    printf "\n   sudo docker exec -it try-iris bash                  - get a bash shell in the container"
    printf "\n   sudo docker exec -it try-iris iris session iris     - get an iris session in the container"
    printf "\n   sudo docker ps -a                                   - list all containers"
    printf "\n   https://docs.docker.com/"
    printf "\n---\n"
}

main