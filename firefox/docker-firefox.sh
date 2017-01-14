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

test -z $(docker images -q firefox) && {
    docker build --no-cache --force-rm -t firefox .
}

test -z $(docker ps -aqf name=firefox) && {
    unset dri_devices
    declare -a dri_devices
    for d in `find /dev/dri -type c`; do
        dri_devices+=(--device "${d}");
    done

    docker create --name firefox -it \
        --env DISPLAY="${DISPLAY}" \
        "${dri_devices[@]}" \
        --volume /run/user/"${UID}"/pulse/native:/tmp/pulse-unix \
        --volume /etc/localtime:/etc/localtime:ro \
        --volume /etc/timezone:/etc/timezone:ro \
        --volume /tmp/.X11-unix:/tmp/.X11-unix \
        firefox
}

docker start firefox
