# Create a systemctl timer serivice to update github hosts where GitHub network is unreachable.

### Step 1
Copy `update-github-hosts.sh` to /usr/local/bin/update-github-hosts.sh
```shell
sudo chmod +x usr/local/bin/update-github-hosts.sh
```

### Step 2
Copy both `update-githubhosts.service` and `update-githubhosts.timer` to 
- /lib/systemd/system/ # if on Debian
- /usr/lib/systemd/system/ # if on Rhel or Fedora

### Step 3
Enable/Start service/timer
```shell
sudo systemctl enable update-githubhosts.service
sudo systemctl enable update-githubhosts.timer
sudo systemctl daemon-reload
sudo systemctl start update-githubhosts.service
sudo systemctl start update-githubhosts.timer
```
### Check results
```shell
journalctl -xe -u update-githubhosts.service # Check service status log
cat /etc/hosts # check if github hosts written in file
```
