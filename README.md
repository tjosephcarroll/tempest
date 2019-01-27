Cloud Marketplace Listing build scripts.

Instructions. 

1. Create an Ubuntu VM.

2. Clone
```
cd /var/lib/cloud/scripts/per-boot/
sudo git clone --single-branch -b Community-Azure-2019.1.0 https://github.com/intersystems/tempest.git
```

2. Build
```
sudo chmod 775 tempest/build/build.sh
sudo tempest/build/build.sh
```

3. Restart machine and the runtime portion (run.sh) will execute. 
