#!/bin/sh

sudo cp victory.service /etc/systemd/system
sudo systemctl daemon-reload
sudo systemctl stop victory.service
sudo systemctl disable victory.service
