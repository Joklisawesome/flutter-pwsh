from atlassian/default-image

WORKDIR .

RUN apt-get update \
    && apt-get install -y wget apt-transport-https software-properties-common \
    && wget -q https://packages.microsoft.com/config/ubuntu/16.04/packages-microsoft-prod.deb \
    && dpkg -i packages-microsoft-prod.deb \
    && apt-get update \
    && apt-get install -y powershell
# POWERSHELL_TELEMETRY_OPTOUT=1

RUN echo "before flutter installation"
RUN ls .

RUN mkdir development \
    && cd development \
    && git clone https://github.com/flutter/flutter.git -b stable \
    && export PATH="$PATH:`pwd`/flutter/bin:${PATH}" \
    && flutter upgrade

RUN echo "after flutter installation"
RUN ls .

ENV PATH="/flutter/bin:${PATH}"

RUN echo "current files in workdir:"
RUN ls .