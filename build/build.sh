#!/bin/bash
#puts everything in the right place.
#this is the thing that actually builds the VM Image
main(){
    config
    source /var/lib/cloud/scripts/per-boot/tempest/build/config/config.sh
    container_kit
    build_scripts
    cloud_cfg
    move_run
    permissions
    clean
}

config(){
    sudo chmod -R 775 /var/lib/cloud/scripts/per-boot/tempest/build/config/config.sh
}

build_scripts(){
    sudo chmod -R 775 /var/lib/cloud/scripts/per-boot/tempest/build/scripts
    run-parts /var/lib/cloud/scripts/per-boot/tempest/build/scripts
}

cloud_cfg(){
    sudo mv /var/lib/cloud/scripts/per-boot/tempest/build/config/cloud.cfg /etc/cloud/cloud.cfg
}

move_run(){
    sudo mv /var/lib/cloud/scripts/per-boot/tempest/build/config/run.sh /var/lib/cloud/scripts/per-boot/run.sh
    sudo mv /var/lib/cloud/scripts/per-boot/tempest/build/config/config.sh /var/lib/cloud/scripts/per-boot/config.sh

}

container_kit(){
    echo "MANUAL STEP PLEASE RUN"
    myip="$(dig +short myip.opendns.com @resolver1.opendns.com)"
    echo "scp $KIT $USER@$myip:/tmp/$KIT"
    read -p "Press any key when ready..."
    sudo mv /tmp/$KIT /var/lib/cloud/scripts/per-boot/$KIT
}

permissions(){
    sudo chmod 775 /var/lib/cloud/scripts/per-boot
    sudo chmod 775 /var/lib/cloud/scripts/per-boot/run.sh
    sudo chmod 775 /var/lib/cloud/scripts/per-boot/config.sh
    sudo chmod 775 /var/lib/cloud/scripts/per-boot/$KIT
}

clean(){
    sudo rm -r /var/lib/cloud/scripts/per-boot/tempest
    cd /var/lib/cloud/scripts/per-boot/
    history -c
}

main