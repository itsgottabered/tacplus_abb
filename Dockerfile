# Command To build this image 
#       docker build --no-cache -t tacplus . 
FROM ubuntu:bionic

# Default Tacacs_Plud directoty inside container /etc/tacacs+
# Default Config File inside container /etc/tacacs+/tac_plus.conf
#
# Command to run the container mapping external tacacs config file
#
# docker run -td --name tacplus \
#            -v <tacplus local config with path>:/etc/tacacs+/tac_plus.conf \
#           tacplus

RUN apt-get update && \
    apt install -y tacacs+ && \
    apt-get clean

COPY startup.sh /usr/local/bin/startup.sh
RUN chmod +x /usr/local/bin/startup.sh

EXPOSE 49
ENTRYPOINT /usr/local/bin/startup.sh && bash
