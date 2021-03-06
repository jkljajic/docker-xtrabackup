FROM    mysql:8.0.21

LABEL   MAINTAINER="Jovo Kljajic <jovo.Kljajic@seavus.com>"

ARG     XTRABACKUP_PREFIX="80"
ARG     XTRABACKUP_VERSION="8.0.14"
ENV     XTRABACKUP_TARGET_DIR="/target" 
ENV     XTRABACKUP_SOURCE_DIR="/var/lib/mysql"

RUN 	apt update && apt install -y wget libdbd-mysql-perl rsync libcurl4-openssl-dev libev4 nmap ncat
#RUN     wget https://www.percona.com/downloads/Percona-XtraBackup-2.4/Percona-XtraBackup-2.4.18/binary/debian/buster/x86_64/percona-xtrabackup-24_2.4.18-1.buster_amd64.deb
#RUN     dpkg -i percona-xtrabackup-24_2.4.18-1.buster_amd64.deb
RUN     wget https://www.percona.com/downloads/Percona-XtraBackup-LATEST/Percona-XtraBackup-${XTRABACKUP_VERSION}/binary/debian/buster/x86_64/percona-xtrabackup-${XTRABACKUP_PREFIX}_${XTRABACKUP_VERSION}-1.buster_amd64.deb
RUN     dpkg -i percona-xtrabackup-${XTRABACKUP_PREFIX}_${XTRABACKUP_VERSION}-1.buster_amd64.deb
RUN     apt-get -qq update 
RUN     apt-get -qq purge wget 
RUN     apt-get -qq autoclean 
RUN     apt-get -qq autoremove 
RUN     rm -rf /tmp/* /var/cache/apt/* /var/cache/depconf/*

#COPY    entrypoint.sh /entrypoint.sh
#VOLUME  /var/backup/mysql

#ENTRYPOINT [ "/entrypoint.sh" ]
CMD ["/bin/bash"]