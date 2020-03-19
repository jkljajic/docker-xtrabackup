FROM    debian:stretch-slim

LABEL   MAINTAINER="Jovo Kljajic <jovo.Kljajic@seavus.com>"

ARG     XTRABACKUP_VERSION="80_0.4-1"
ENV     XTRABACKUP_TARGET_DIR="/target" \
        XTRABACKUP_SOURCE_DIR="/var/lib/mysql"

RUN     set -x 
RUN     wget -c https://dev.mysql.com/get/mysql-apt-config_0.8.11-1_all.deb 
RUN     wget https://www.percona.com/downloads/XtraBackup/Percona-XtraBackup-8.0.4/binary/debian/stretch/x86_64/percona-xtrabackup-80_8.0.4-1.stretch_amd64.deb
RUN     dpkg -i mysql-apt-config_0.8.11-1_all.deb
RUN     dpkg -i percona-xtrabackup-80_0.4-1.stretch_amd64.deb
RUN     apt-get -qq update 
RUN     apt-get -qq install wget mysql-client nmap 
RUN     apt-get -qq purge wget 
RUN     apt-get -qq autoclean 
RUN     apt-get -qq autoremove 
RUN     rm -rf /tmp/* /var/cache/apt/* /var/cache/depconf/*

COPY    entrypoint.sh /entrypoint.sh
VOLUME  /var/backup/mysql

ENTRYPOINT [ "/entrypoint.sh" ]
