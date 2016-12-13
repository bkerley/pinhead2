#!/bin/bash
sudo systemctl stop victory
sudo systemctl disable victory
sudo systemctl stop level2.socket
sudo systemctl disable level2.socket
