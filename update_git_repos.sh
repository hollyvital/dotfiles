#!/bin/sh
cd krakoa/
git pull
printf "Krakoa updated\n=======================\n"
cd ../vitalone-device
git pull
git submodule update --init --recursive
printf "Vitalone Device and submodules updated\n=======================\n"
cd ../software-operations
git pull
echo "Software-operations updated"
