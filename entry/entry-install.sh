#!/bin/sh

sudo cp entry.service /etc/systemd/system
sudo systemctl daemon-reload
sudo systemctl start entry.service
sudo systemctl enable entry.service
