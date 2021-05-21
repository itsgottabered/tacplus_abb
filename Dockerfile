# Command To build this image 
#       docker build --no-cache -t tacplus . 
FROM ubuntu:bionic

# Default Tacacs_Plud directoty inside container /etc/tacacs+
# Default Config File inside container /etc/tacacs+/tac_plus.conf
#

RUN apt-get update && \
    apt-get install -y tacacs+ rsyslog && \
    apt-get clean

COPY startup.sh /usr/local/bin/startup.sh
RUN chmod +x /usr/local/bin/startup.sh

EXPOSE 49
ENTRYPOINT /usr/local/bin/startup.sh && bash
