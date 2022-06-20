FROM ubuntu:18.04

RUN apt-get update

RUN apt-get install -y --no-install-recommends \
  build-essential \
  apt-utils \
  pandoc \
  curl \
  locales

RUN localedef -i en_US -f UTF-8 en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN apt-get install -y \
  graphviz

# gnuplot

RUN apt-get install -y \
  python3.6 \
  python3-pip \
  python-seqdiag
RUN pip3 install pandocfilters

RUN echo "alias python='python3'\nalias pip='pip3'" >> /root/.bashrc
RUN ln -sf /usr/bin/python3 /usr/bin/python
  # printf '#!/usr/bin/env bash \n python3 $@' > /usr/bin/python && chmod +x /usr/bin/python

ARG bin_path=/usr/local/bin
ARG libs_path=/usr/local/lib/documentary
ARG plugins_path=$libs_path/plugins
ARG resources_path=$libs_path/resources

RUN mkdir -p $libs_path

COPY documentary watcher makefile $bin_path/
COPY plugins $plugins_path
COPY resources $resources_path

ENV BIN_PATH $bin_path
ENV LIBS_PATH $libs_path
ENV PLUGINS_PATH $plugins_path
ENV RESOURCES_PATH $resources_path

ENV SOURCE_DIR /app/source
ENV TARGET_DIR /app/docs
WORKDIR /app

# Install Forego
# ADD https://github.com/jwilder/forego/releases/download/v0.16.1/forego /usr/local/bin/forego
# RUN chmod u+x /usr/local/bin/forego

# ENTRYPOINT ["/app/docker-entrypoint.sh"]
# CMD ["forego", "start", "-r"]