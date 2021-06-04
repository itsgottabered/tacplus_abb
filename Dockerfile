# Command To build this image 
#       docker build --no-cache -t tacplus . 
FROM ubuntu:bionic

# Default Tacacs_Plud directoty inside container /etc/tacacs+
# Default Config File inside container /etc/tacacs+/tac_plus.conf
#

RUN apt-get update && \
    apt-get install -y tacacs+ rsyslog build-essential libnet-ldap-perl libpcre3-dev&& \
    apt-get clean

RUN cd ~
RUN wget http://www.pro-bono-publico.de/projects/src/DEVEL.tar.bz2
RUN bzip2 -dc DEVEL.tar.bz2 | tar xvfp -
RUN cd PROJECTS
RUN make
RUN make install
RUN mkdir -p /var/log/tac_plus/access
RUN mkdir -p /var/log/tac_plus/accounting
RUN mkdir -p /var/log/tac_plus/authentication

COPY startup.sh /usr/local/bin/startup.sh
RUN chmod +x /usr/local/bin/startup.sh

EXPOSE 49
ENTRYPOINT /usr/local/bin/startup.sh && bash
