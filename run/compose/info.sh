#!/bin/bash

main(){
    if [ "$(sudo docker ps -a | grep try-iris)" ]
    then
        ip=$(dig +short myip.opendns.com @resolver1.opendns.com)
        printf "\nIP: $ip"
        printf "\nSuperserver Port: 51773"
        printf "\nWeb Server Port: 52773"
        printf "\nJDBC connection string: jdbc:IRIS://$ip:51773/USER"
        printf "\nManagement Portal URL: http://$ip:52773/csp/sys/UtilHome.csp"
        printf "\n"
    else
        printf "\nThere is no running container named try-iris\n"
    fi   
}

main