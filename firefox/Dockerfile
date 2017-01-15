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

FROM ubuntu:14.04

MAINTAINER Dittmar Steiner <dittmar.steiner@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV SOCKS_SERVER="socks://172.17.0.1:5080"
ENV SOCKS_VERSION=5
ENV PULSE_SERVER="unix:/tmp/pulse-unix"

RUN echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula boolean true | debconf-set-selections \
  && apt-get -y update \
  && apt-get -y dist-upgrade \
  && apt-get -y install \
     apt-transport-https \
     software-properties-common \
  && apt-add-repository -y multiverse \
  && apt-add-repository -y ppa:nilarimogard/webupd8 \
  && apt-add-repository -y ppa:pipelight/stable \
  && apt-get -y update \
  && apt-get -y install \
     dbus-x11 \
     pulseaudio \
     gstreamer1.0-pulseaudio \
     gstreamer1.0-plugins-good \
     ubuntu-restricted-extras \
     libgl1-mesa-glx-lts-vivid \
     libgl1-mesa-dri-lts-vivid \
     libtxc-dxtn-s2tc0 \
     mesa-vdpau-drivers-lts-vivid \
     libvdpau-va-gl1 \
     i965-va-driver \
     vdpau-va-driver \
     libcanberra-gtk3-0 \
     openvpn \
     firefox \
  && apt-get -y autoremove \
  && apt-get -y clean \
  && groupadd -g 1000 ff \
  && useradd -u 1000 -g ff ff \
  && usermod -aG video ff \
  && usermod -aG audio ff \
  && mkdir -p /home/ff \
  && chown ff:ff /home/ff

USER ff

ENTRYPOINT ["/usr/bin/firefox"]
CMD ["-new-instance"]
