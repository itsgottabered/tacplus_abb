# Command To build this image 
#       docker build --no-cache -t tacplus . 
FROM ubuntu:bionic

# Default Tacacs_Plud directoty inside container /etc/tacacs+
# Default Config File inside container /etc/tacacs+/tac_plus.conf
#

RUN apt-get update && \
    apt-get install -y rsyslog build-essential libnet-ldap-perl libpcre3-dev wget && \
    apt-get clean

RUN cd ~
RUN wget http://www.pro-bono-publico.de/projects/src/DEVEL.tar.bz2
RUN bzip2 -dc DEVEL.tar.bz2 | tar xvfp -
RUN cd PROJECTS && make && make install
RUN mkdir -p /var/log/tac_plus/access
RUN mkdir -p /var/log/tac_plus/accounting
RUN mkdir -p /var/log/tac_plus/authentication

COPY startup.sh /usr/local/bin/startup.sh
RUN chmod +x /usr/local/bin/startup.sh

EXPOSE 49
ENTRYPOINT bash
