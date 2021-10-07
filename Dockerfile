# Create a container from Ubuntu.
FROM ubuntu:18.04

# Credits.
MAINTAINER Andrés Sánchez

# Update Ubuntu repositories.
RUN apt-get update

# Install Python.
RUN apt update && apt -y dist-upgrade \
  && apt-get install -y python3-pip python3-dev \
  && cd /usr/local/bin \
  && ln -s /usr/bin/python3 python \
  && pip3 install --upgrade pip

# Create a working directory.
RUN mkdir deployment

# Install VirtualEnv.
RUN pip install virtualenv

# Add requirements file.
ADD requirements.txt /deployment/requirements.txt

ADD ServicioREST /deployment/ServicioREST

# Run VirtualEnv.
RUN virtualenv /deployment/env/
RUN /deployment/env/bin/pip install wheel
RUN /deployment/env/bin/pip install -r /deployment/requirements.txt

ARG USR
ARG PASS
ARG HOST

ENTRYPOINT deployment/env/bin/python deployment/ServicioREST/main.py ${USR} ${PASS} ${HOST}