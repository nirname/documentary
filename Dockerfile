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

# Copy executables
COPY app $documentary_path

# Make documentary and ndoc (alias) commands available
RUN \
  ln -s $documentary_path/bin/documentary /usr/local/bin/documentary && \
  ln -s $documentary_path/bin/documentary /usr/local/bin/ndoc

ENV DOCUMENTARY_PATH $documentary_path

# A user's project are mounted to /local
ENV PROJECT_PATH /local
ENV SOURCE_DIR src
ENV TARGET_DIR docs
WORKDIR /local

# Install Forego
# ADD https://github.com/jwilder/forego/releases/download/v0.16.1/forego /usr/local/bin/forego
# RUN chmod u+x /usr/local/bin/forego

ENTRYPOINT ["ndoc"]
# ENTRYPOINT ["/app/docker-entrypoint.sh"]
# CMD ["forego", "start", "-r"]
