FROM debian:stretch

MAINTAINER Deni Bertovic "deni@denibertovic.com"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get -y --no-install-recommends install \
    locales \
    gosu \
    openssh-client \
    python

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

RUN echo "en_US ISO-8859-1" >> /etc/locale.gen
RUN echo "en_US.ISO-8859-15 ISO-8859-15" >> /etc/locale.gen
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN apt-get update && apt-get install -y --no-install-recommends  \
    tmate \
    vim \
    vim-nox

WORKDIR /opt/workdir

