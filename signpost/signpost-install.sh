#!/bin/sh

sudo cp signpost.service /etc/systemd/system
sudo systemctl daemon-reload
sudo systemctl start signpost.service
sudo systemctl enable signpost.service
