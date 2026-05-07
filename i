#!/bin/bash

pkg i curl bc jq termux-services -y
curl -LO https://raw.githubusercontent.com/Stan-Di/nightscout2vk/refs/heads/main/vk.sh
chmod 755 vk.sh
nano vk.sh
