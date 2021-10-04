# Create a container from Ubuntu.
#https://guido-barbaglia.blog/docker/
FROM ubuntu:18.04

# Credits.
MAINTAINER Guido Barbaglia "guido.barbaglia@gmail.com"

# Update Ubuntu repositories.
RUN apt-get update

# Install Python.
RUN apt-get install -y -q build-essential python-gdal python-simplejson
RUN apt-get install -y python python3-pip wget
#RUN apt-get install -y python-dev

# Create a working directory.
RUN mkdir deployment

# Install VirtualEnv.
RUN pip install virtualenv

# Add requirements file.
ADD requirements.txt /deployment/requirements.txt

# Add the script that will start everything.
ADD start.py /deployment/start.py

# Run VirtualEnv.
RUN virtualenv /deployment/env/
RUN /deployment/env/bin/pip install wheel
RUN /deployment/env/bin/pip install -r /deployment/requirements.txt