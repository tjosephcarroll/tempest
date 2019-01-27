#!/bin/bash
#runs the scripts in master directory in order.
# This is extensible
main(){
    run-parts /var/lib/cloud/scripts/per-boot/tempest/run/load
    clean
} 

clean(){
    sudo rm -r /var/lib/cloud/scripts/per-boot/*
}

main