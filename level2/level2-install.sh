#!/bin/sh

sudo cp level2.socket level2@.service /etc/systemd/system
sudo systemctl daemon-reload
sudo systemctl disable level2.socket
sudo systemctl stop level2.socket
