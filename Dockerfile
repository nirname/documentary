FROM ubuntu:18.04

RUN apt-get update && \
  apt-get install -y build-essential pandoc graphviz curl

RUN apt-get install -y python3.4 python-pip

RUN pip install pandocfilters seqdiag

ENV SOURCE_DIR /project/source
ENV TARGET_DIR /project/docs

RUN mkdir /app
COPY documentary /bin
COPY plugins makefile /app/

WORKDIR /project

# Install Forego
# ADD https://github.com/jwilder/forego/releases/download/v0.16.1/forego /usr/local/bin/forego
# RUN chmod u+x /usr/local/bin/forego

# ENTRYPOINT ["/app/docker-entrypoint.sh"]
# CMD ["forego", "start", "-r"]