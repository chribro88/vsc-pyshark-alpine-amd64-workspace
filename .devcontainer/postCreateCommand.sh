#!/bin/sh --login

# Create Virtual Environment
FILE=/tmp/conda-tmp/environment.yml
# if [ -f "$FILE" ]; then
if [ true ]; then
    env_name=$(cat /tmp/conda-tmp/environment.yml | grep "name: " | awk -F": " '{print $2}')
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc
    echo "conda activate" >> ~/.bashrc
    echo "conda activate $env_name" >> ~/.bashrc
    echo "clear" >> ~/.bashrc
    # attempt fix weird terminal output by setting COLUMNS (still doesn't work)
    COLUMNS=55 conda env create --file /tmp/conda-tmp/environment.yml --force
    # rm -f /tmp/conda-tmp/environment.yml
fi

# Python Version 
echo $(python3 --version)