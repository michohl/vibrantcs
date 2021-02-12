# VibrantCS

NVIDIA provides a way to set the 'Digital Vibrance' which improves the contrast for a game where you may gain an advantage such as CS:GO. 


## Simple Execution

If you want to run the script manually from a terminal in the background you can simply download the scripts and update the `PRIMARY_MONITOR` value to match your nvidia-settings panel then execute the script with `/bin/bash`.

## Systemd Service Installation

If you want to enable this program to **always** be running in the background and start at bootup time via systemd then you can use the following steps. 

```bash
# You need to enable xhost so the systemd service can communicate properly
echo "xhost +" >> ~/.bashrc

# NOTE: Before copying this file make sure you update the "User" and "ExecStart" fields
sudo cp vibrantcs.service /etc/systemd/system/vibrantcs.service

sudo systemctl start vibrantcs
sudo systemctl enable vibrantcs
# 
```
