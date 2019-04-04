FROM ubuntu:18.04

RUN apt-get update && \
  apt-get install -y build-essential pandoc graphviz curl

RUN apt-get install -y python3.4 python-pip

RUN pip install pandocfilters seqdiag