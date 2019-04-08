FROM ubuntu:18.04

RUN apt-get update && \
  apt-get install -y build-essential pandoc graphviz curl locales

RUN apt-get install -y python3.4 python-pip

RUN pip install pandocfilters seqdiag

RUN mkdir /app
COPY plugins /app/plugins
COPY resources /app/resources
COPY makefile /app

COPY documentary /bin

ENV PLUGINS_DIR /app/plugins
ENV RESOURCES_DIR /app/resources
ENV APP_DIR /app

ENV SOURCE_DIR /project/source
ENV TARGET_DIR /project/docs

WORKDIR /project

RUN localedef -i en_US -f UTF-8 en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# Install Forego
# ADD https://github.com/jwilder/forego/releases/download/v0.16.1/forego /usr/local/bin/forego
# RUN chmod u+x /usr/local/bin/forego

# ENTRYPOINT ["/app/docker-entrypoint.sh"]
# CMD ["forego", "start", "-r"]