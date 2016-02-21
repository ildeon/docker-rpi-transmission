FROM armbuild/debian:jessie
MAINTAINER ildeon

RUN echo "deb http://mirrordirector.raspbian.org/raspbian/ jessie main contrib non-free" | tee -a /etc/apt/sources.list && \
    echo "deb http://archive.raspbian.org/raspbian jessie main contrib non-free" | tee -a /etc/apt/sources.list && \
    echo "Package: *\nPin: release n=jessie\nPin-Priority: -1\n" > /etc/apt/preferences.d/jessie.pref && \
    echo "Package: *\nPin: release n=wheezy\nPin-Priority: 989\n" > /etc/apt/preferences && \
    apt-get update && \
    apt-get install -t jessie transmission-daemon transmission-cli -y && \
    adduser --system -shell "/bin/bash" --uid 1000 --disabled-password --group --home /var/lib/transmission transmission && \
    groupadd media && \
    usermod -a -G media transmission && \
  apt-get -y autoremove && \
  apt-get -y clean && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /tmp/*

RUN mkdir -p /downloads/complete && mkdir -p /downloads/incomplete && chown -R transmission:transmission /downloads

VOLUME ["/config", "/downloads"]

EXPOSE 9091

USER transmission

ENTRYPOINT [ "transmission-daemon","-a", "*.*.*.*", "-t","--incomplete-dir", "/downloads/incomplete","-w", "/downloads/complete","-f","-g", "/config"]
