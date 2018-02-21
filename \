FROM ubuntu:14.04
MAINTAINER Micheal Waltz <ecliptik@gmail.com>
# see http://www.ecliptik.com/Containerizing-a-Perl-Script/

# Dockerfile by Johannes Eiseler 6/2017
# 
# How to build:
# docker build -t perl-oracle .

# How to run:
# docker run -it --rm perl-oracle
# docker run -v /c/Users/myuser/directory/you/like/to/share:/host/directory -it --rm perl-oracle

ENV DEBIAN_FRONTEND=noninteractive LANG=en_US.UTF-8 LC_ALL=C.UTF-8 LANGUAGE=en_US.UTF-8

RUN [ "apt-get", "-q", "update" ]
RUN [ "apt-get", "-qy", "--force-yes", "upgrade" ]
RUN [ "apt-get", "-qy", "--force-yes", "dist-upgrade" ]
RUN [ "apt-get", "install", "-qy", "--force-yes", \
      "perl", \
      "build-essential", \
      "cpanminus" ]
RUN [ "apt-get", "clean" ]
RUN [ "rm", "-rf", "/var/lib/apt/lists/*", "/tmp/*", "/var/tmp/*" ]

#RUN ["cpanm", "Proc::ProcessTable", "Data::Dumper" ]

COPY [ "./oracle_test.pl", "/app/oracle_test.pl" ]
RUN [ "chmod", "+x",  "/app/oracle_test.pl" ]

# now Oracle
# see http://www.aboutmonitoring.com/install-dbd-oracle-perl-modules-in-linux/

COPY [ "./*.rpm", "/app/" ]

WORKDIR /app
RUN ["apt-get", "update"]
RUN ["apt-get", "install", "libaio-dev", "libaio1" ]
RUN ["apt-get", "install", "-qy", "--force-yes", "alien" ]

RUN alien --scripts /app/oracle-instantclient12.2-basic-12.2.0.1.0-1.x86_64.rpm
RUN alien --scripts /app/oracle-instantclient12.2-devel-12.2.0.1.0-1.x86_64.rpm
RUN alien --scripts /app/oracle-instantclient12.2-sqlplus-12.2.0.1.0-1.x86_64.rpm

RUN dpkg -i /app/oracle-instantclient12.2-basic_12.2.0.1.0-2_amd64.deb
RUN dpkg -i /app/oracle-instantclient12.2-devel_12.2.0.1.0-2_amd64.deb
RUN dpkg -i /app/oracle-instantclient12.2-sqlplus_12.2.0.1.0-2_amd64.deb

ENV PATH $PATH:$HOME/bin:/usr/lib/oracle/12.2/client64/bin
ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:/usr/lib/oracle/12.2/client64/lib
ENV ORACLE_HOME /usr/lib/oracle/12.2/client64/lib
ENV TNS_ADMIN $ORACLE_HOME/network/admin

# now perl oracle
RUN ["apt-get", "install", "-qy", "--force-yes", "libdbi-perl" ]
RUN ["cpan", "DBD::Oracle"]

# if you wan't to use it interactivly comment the next line
ENTRYPOINT [ "/app/oracle_test.pl" ]
