FROM debian:latest

MAINTAINER Carlos Amorim

ENV TZ=America/Fortaleza
ENV PATH=$PATH:/var/lib/postgresql/bin

USER root

RUN echo -e "deb http://deb.debian.org/debian/ bookworm main non-free-firmware\ndeb-src http://deb.debian.org/debian/ bookworm main non-free-firmware\n\ndeb http://security.debian.org/debian-security bookworm-security main non-free-firmware\ndeb-src http://security.debian.org/debian-security bookworm-security main non-free-firmware\n\ndeb http://deb.debian.org/debian/ bookworm-updates main non-free-firmware\ndeb-src http://deb.debian.org/debian/ bookworm-updates main non-free-firmware"
RUN apt update -y
RUN apt install wget gcc zlib1g-dev libreadline6-dev docbook-dsssl docbook libreadline-dev libperl-dev libedit-dev libpam0g-dev libpam-dev libkrb5-dev libldap2-dev libxslt1-dev libossp-uuid-dev bison flex opensp tcl-dev xsltproc linux-headers-amd64 linux-headers-$(uname -r) -y
RUN apt install locales -y && echo "locales locales/default_environment_locale select pt_BR.UTF-8" | debconf-set-selections && echo "locales locales/locales_to_be_generated multiselect pt_BR.UTF-8 UTF-8" | debconf-set-selections && rm "/etc/locale.gen" && dpkg-reconfigure --frontend=noninteractive locales && update-locale "LANG=pt_BR.UTF-8"
RUN cd root/ && wget --continue https://ftp.postgresql.org/pub/source/v9.6.24/postgresql-9.6.24.tar.gz && tar -xzf postgresql-9.6.24.tar.gz
RUN cd /root/postgresql-9.6.24 && ./configure --prefix=/var/lib/postgresql && make && make install
RUN useradd -M postgres -d /var/lib/postgresql && chown postgres:postgres -R /var/lib/postgresql
RUN mkdir -p /var/lib/postgresql/data && chown postgres:postgres -R /var/lib/postgresql/data && chmod 700 /var/lib/postgresql/data
COPY ./entry-point.sh /var/lib/postgresql/
RUN chmod +x /var/lib/postgresql/entry-point.sh
USER postgres
