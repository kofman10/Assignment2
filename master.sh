#!/bin/bash

ssh-keygen -t rsa

ssh-copy-id vagrant@192.168.56.11

sudo adduser altschool

sudo usermod -aG sudo altschool

su - altschool

scp -r /mnt vagrant@192.168.56.11:/mnt
