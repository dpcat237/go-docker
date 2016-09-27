#!/bin/bash

service ssh start

/bin/bash -l -c "$*"
echo -e "\033[32m Application started"
