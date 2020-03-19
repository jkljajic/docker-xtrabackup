FROM    mysql:8.0.19

LABEL   MAINTAINER="Jovo Kljajic <jovo.Kljajic@seavus.com>"

ARG     XTRABACKUP_VERSION="80_0.10-1"
ENV     XTRABACKUP_TARGET_DIR="/target" 
ENV     XTRABACKUP_SOURCE_DIR="/var/lib/mysql"

RUN 	apt update && apt install -y wget libdbd-mysql-perl rsync libcurl4-openssl-dev libev4
RUN     wget https://www.percona.com/downloads/Percona-XtraBackup-LATEST/Percona-XtraBackup-8.0-10/binary/debian/buster/x86_64/percona-xtrabackup-80_8.0.10-1.buster_amd64.deb
RUN     dpkg -i percona-xtrabackup-80_8.0.10-1.buster_amd64.deb
RUN     apt-get -qq update 
RUN     apt-get -qq purge wget 
RUN     apt-get -qq autoclean 
RUN     apt-get -qq autoremove 
RUN     rm -rf /tmp/* /var/cache/apt/* /var/cache/depconf/*

COPY    entrypoint.sh /entrypoint.sh
VOLUME  /var/backup/mysql

ENTRYPOINT [ "/entrypoint.sh" ]
