FROM ubuntu:22.04

RUN apt-get clean && apt-get update

RUN apt-get install -y \
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
  python3-seqdiag
RUN pip3 install pandocfilters seqdiag

RUN echo "alias python='python3'\nalias pip='pip3'\n alias seqdiag='seqdiag3'" >> /root/.bashrc
RUN ln -sf /usr/bin/python3 /usr/bin/python
  # printf '#!/usr/bin/env bash \n python3 $@' > /usr/bin/python && chmod +x /usr/bin/python

ARG documentary_path=/opt/documentary
RUN mkdir -p $documentary_path

# ARG documentary_bin_path=$documentary_path/bin
# ARG documentary_plugins_path=$documentary_path/plugins
# ARG documentary_resources_path=$ocumentary_path/resources
COPY app $documentary_path

# Make documentary command available
RUN ln -s $documentary_path/bin/documentary /usr/local/bin/documentary

ENV DOCUMENTARY_PATH $documentary_path

# COPY plugins $plugins_path
# COPY resources $resources_path

# This is where user's markdown files are mounted
ENV SOURCE_DIR /app/source
ENV TARGET_DIR /app/docs
WORKDIR /app

# Install Forego
# ADD https://github.com/jwilder/forego/releases/download/v0.16.1/forego /usr/local/bin/forego
# RUN chmod u+x /usr/local/bin/forego

ENTRYPOINT ["documentary"]
# ENTRYPOINT ["/app/docker-entrypoint.sh"]
# CMD ["forego", "start", "-r"]
