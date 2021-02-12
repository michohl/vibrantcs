# VibrantCS

NVIDIA provides a way to set the 'Digital Vibrance' which improves the contrast for a game where you may gain an advantage such as CS:GO. 


## Simple Execution

If you want to run the script manually from a terminal in the background you can simply download the scripts and update the `PRIMARY_MONITOR` value to match your nvidia-settings panel then execute the script with `/bin/bash`.

Before running the script you'll also want to ensure the `--query` flag matches the monitor you're going to be running on the game. To find this value use the following commands:

```bash
# Get a list of the GPUs you can choose from. Typically should only be one reasonable choice here
nvidia-settings -q gpus

1 GPU on Nekrogoblikon:0

    [0] Nekrogoblikon:0[gpu:0] (GeForce RTX 2070 SUPER)

      Has the following names:
        GPU-0
        GPU-f3c1a429-7658-bc60-9ee6-d2712a5329c5

# Get the displays connected to the GPU (I imagine there's a better way I just haven't found it)
nvidia-settings -L | awk '{print $NF}' | sed '/^[[:space:]]*$/d' | uniq | sed 's/[()]//g'
SCREEN-0
DP-0
HDMI-0
DP-4
```

Then pick whichever screen looks the most reasonable. and substitute that into the main script where I have `DISPLAY` being set

## Systemd Service Installation

If you want to enable this program to **always** be running in the background and start at bootup time via systemd then you can use the following steps. 

```bash
# You need to enable xhost so the systemd service can communicate properly
echo "xhost +" >> ~/.bashrc

# NOTE: Before copying this file make sure you update the "User" and "ExecStart" fields
sudo cp vibrantcs.service /etc/systemd/system/vibrantcs.service

sudo systemctl start vibrantcs
sudo systemctl enable vibrantcs 
```
