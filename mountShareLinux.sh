#!/bin/bash

sharedHost="192.168.33.10"
sharedHome="vagrant"
sharedPassword="vagrant"

# sudo mount -t nfs -o rsize=32768,wsize=32768,vers=3,proto=tcp ${sharedHost}:/home/${sharedHome} ./shared
sudo mount -t nfs -o rsize=32768,wsize=32768,proto=tcp ${sharedHost}:/home/${sharedHome} ./shared

# EOF
