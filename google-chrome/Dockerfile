# ------------------------------------------------------------------------------
# ISC License http://opensource.org/licenses/isc-license.txt
# ------------------------------------------------------------------------------
# Copyright (c) 2016, Dittmar Steiner <dittmar.steiner@googlemail.com>
# 
# Permission to use, copy, modify, and/or distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
# 
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
# ------------------------------------------------------------------------------

# Note: just run:
# $ ./docker-firefox.sh

FROM debian:stable

MAINTAINER Dittmar Steiner <dittmar.steiner@gmail.com>

ADD https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb /src/google-chrome-stable_current_amd64.deb

# Install Chromium and PulseAudio with minimal dependencies
RUN apt-get -y update \
  && apt-get -y install \
     ca-certificates \
     fonts-liberation \
     gconf-service \
     hicolor-icon-theme \
     libappindicator1 \
     libasound2 \
     libcanberra-gtk-module \
     libcurl3 \
     libexif-dev \
     libgconf-2-4 \
     libgl1-mesa-dri \
     libgl1-mesa-glx \
     libnspr4 \
     libnss3 \
     libpango1.0-0 \
     libv4l-0 \
     libxss1 \
     libxtst6 \
     openvpn \
     pulseaudio \
     wget \
     xdg-utils \
     --no-install-recommends \
  && dpkg -i '/src/google-chrome-stable_current_amd64.deb' \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /src/*.deb \
  && echo "\n\
    pcm.pulse {\n\
        type pulse\n\
    }\n\
    ctl.pulse {\n\
        type pulse\n\
    }\n\
    pcm.!default {\n\
        type pulse\n\
    }\n\
    ctl.!default {\n\
        type pulse\n\
    }" > /etc/asound.conf \
    && echo "\
<?xml version='1.0'?>\
<!DOCTYPE fontconfig SYSTEM 'fonts.dtd'>\
<fontconfig>\
 <match target=\"font\">\
  <edit mode=\"assign\" name=\"rgba\">\
   <const>rgb</const>\
  </edit>\
 </match>\
 <match target=\"font\">\
  <edit mode=\"assign\" name=\"hinting\">\
   <bool>true</bool>\
  </edit>\
 </match>\
 <match target=\"font\">\
  <edit mode=\"assign\" name=\"hintstyle\">\
   <const>hintslight</const>\
  </edit>\
 </match>\
 <match target=\"font\">\
  <edit mode=\"assign\" name=\"antialias\">\
   <bool>true</bool>\
  </edit>\
 </match>\
  <match target=\"font\">\
    <edit mode=\"assign\" name=\"lcdfilter\">\
      <const>lcddefault</const>\
    </edit>\
  </match>\
</fontconfig>" > /etc/fonts/conf.d/99-chrome.conf \
  && echo "enable-shm = no" >> /etc/pulse/client.conf \
  && groupadd -g 1000 gc \
  && useradd -u 1000 -g gc gc \
  && usermod -aG video gc \
  && usermod -aG audio gc \
  && mkdir -p /home/gc \
  && chown gc:gc /home/gc

ENV HOME /home/gc

USER gc

# Autorun chrome
ENTRYPOINT [ "google-chrome" ]
CMD [ "--no-sandbox", "--app:about:blank" ]
