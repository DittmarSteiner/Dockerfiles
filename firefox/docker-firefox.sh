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

(docker images -q firefox | grep -qE '[a-z0-9]+') || {
    docker build --no-cache --force-rm -t firefox .
}

(docker ps -aqf name=firefox | grep -qE '[a-z0-9]+') || {
    unset dri_devices
    declare -a dri_devices
    for d in `find /dev/dri -type c`; do
        dri_devices+=(--device "${d}":"${d}");
    done

    docker create -i \
        --name firefox \
        --env DISPLAY="${DISPLAY}" \
        --cap-add=NET_ADMIN \
        --device /dev/net/tun \
        "${dri_devices[@]}" \
        --volume /run/user/"${UID}"/pulse/native:/tmp/pulse-unix \
        --volume /etc/localtime:/etc/localtime:ro \
        --volume /etc/timezone:/etc/timezone:ro \
        --volume /tmp/.X11-unix:/tmp/.X11-unix \
        firefox -safe-mode --no-remote
}

docker start firefox
