from atlassian/default-image

#RUN useradd -ms /bin/bash developer
#USER developer
WORKDIR /home/developer

RUN apt-get update \
     && apt-get install -y wget apt-transport-https software-properties-common \
     && wget -q https://packages.microsoft.com/config/ubuntu/16.04/packages-microsoft-prod.deb \
     && dpkg -i packages-microsoft-prod.deb \
     && apt-get update \
     && apt-get install -y powershell
 # POWERSHELL_TELEMETRY_OPTOUT=1

RUN echo "Current directory and pwd"
RUN ls . && pwd

RUN git clone https://github.com/flutter/flutter.git -b stable \
    #&& export PATH="$PATH:`pwd`/flutter/bin:${PATH}" \
    #&& flutter upgrade

ENV PATH "$PATH:/home/developer/flutter/bin"

RUN flutter upgrade

RUN flutter doctor