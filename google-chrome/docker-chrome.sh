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

#!/bin/bash

set -e

(docker images -q chrome | grep -qE '[a-z0-9]+') || {
    docker build --no-cache --force-rm -t chrome .
}

xhost si:localuser:$USER

(pax11publish -d | grep -qE '.+') || {
    start-pulseaudio-x11
}

(docker ps -aqf name=chrome | grep -qE '[a-z0-9]+') || {
    docker create -i \
        --name chrome \
        --cap-add=NET_ADMIN \
        --device /dev/net/tun \
        -v /etc/localtime:/etc/localtime:ro \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        -e DISPLAY=$DISPLAY \
        -e PULSE_SERVER=tcp:localhost:4713 \
        -e PULSE_COOKIE_DATA=`pax11publish -d | grep --color=never -Po '(?<=^Cookie: ).*'` \
        --group-add audio \
        --group-add video \
        --user `id -u`:`getent group video | cut -d: -f3` \
        --device /dev/dri \
        chrome
}

docker start chrome
