#!/bin/bash
#pulls git repo and cleans up key
main(){
    source /var/lib/cloud/scripts/per-boot/config.sh
    add_to_known_hosts
    clone_repo
    #runs master.sh
    sudo chmod -R 775 /var/lib/cloud/scripts/per-boot/tempest
    sudo /var/lib/cloud/scripts/per-boot/tempest/run/master.sh
}

clone_repo(){

    #what branch to clone and temp directory name!
    branch=$BRANCH
    ranNum=$(($(od -An -N1 -tu1 /dev/urandom)))

    #prep for clone
    sudo mkdir /var/lib/cloud/scripts/per-boot/tempest
    sudo rm -rf /var/lib/cloud/scripts/per-boot/tempest
    
    #clone
    sudo ssh-agent bash -c 'ssh-add /var/lib/cloud/scripts/per-boot/ssh.key; git clone --single-branch -b '"${branch}"' git@github.com:tjosephcarroll/tempest.git /var/lib/cloud/scripts/per-boot/'"${ranNum}"''
    
    #move and clean
    sudo mkdir /var/lib/cloud/scripts/per-boot/tempest
    sudo mv /var/lib/cloud/scripts/per-boot/${ranNum}/* /var/lib/cloud/scripts/per-boot/tempest
    sudo rm -r ${ranNum}
}

add_to_known_hosts(){
	sudo mkdir -p /root/.ssh
	sudo touch /root/.ssh/known_hosts
	sudo chmod 600 /root/.ssh/known_hosts
	sudo ssh-keyscan -H github.com >> /tmp/known_hosts
	sudo cp /tmp/known_hosts /root/.ssh/known_hosts
}

main