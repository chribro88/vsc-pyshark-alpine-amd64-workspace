#!/bin/sh --login

CONDA_DIR=/workspace/.conda
TMP_FILE=/tmp/conda-tmp/environment.yml
FILE=$CONDA_DIR/environment.yml

if [ ! -d "$CONDA_DIR" ]; then
mkdir "$CONDA_DIR"
fi

if [ ! -f "$FILE" ]; then
    cp "$TMP_FILE" "$CONDA_DIR"
fi

# Create Virtual Environment
if [ -f "$FILE" ]; then
    env_name=$(cat $FILE | grep "name: " | awk -F": " '{print $2}')
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc
    echo "conda activate" >> ~/.bashrc
    echo "conda activate $env_name" >> ~/.bashrc
    echo "clear" >> ~/.bashrc
    # attempt fix weird terminal output by setting COLUMNS (still doesn't work)
    conda env create --file $FILE --prefix=$CONDA_DIR/envs/$env_name --force
    # rm -f /tmp/conda-tmp/environment.yml
fi

# Python Version 
echo $(python3 --version)
