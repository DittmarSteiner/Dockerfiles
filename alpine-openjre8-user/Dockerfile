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

# Build with defaults:
# $ sudo docker build --force-rm -t me ./
# Pass with your user ID and name:
# $ sudo docker build --force-rm --build-arg UID=$(id -u) --build-arg USERNAME=$(id -un) -t me ./
# 
# Example with a volume and the current dir as container name:
# $ sudo docker run --rm -itv `pwd`:/app --name $(basename `pwd`) me
# 
# Need root access?
# $ sudo docker exec -itu root $(basename `pwd`) sh
# Need to persist latest mods?
# $ sudo docker commit $(basename `pwd`) me
# But you will need to delete <none> images manually:
# $ sudo docker images
# (better write a Dockerfile...)

FROM openjdk:8-jre-alpine

MAINTAINER Dittmar Steiner <dittmar.steiner@gmail.com>

ENV LANG C.UTF-8
ENV JAVA_TOOL_OPTIONS '-Dfile.encoding=UTF8 -Dsun.jnu.encoding=UTF-8'

ARG UID=1000
ARG USERNAME=me

# Note: no home dir, '/app' is the only dir the user has write access
RUN adduser -HD -u ${UID} ${USERNAME} \
 && mkdir -p /app \
 && chown ${USERNAME} /app \
 && apk --update add curl unzip \
 && cd /tmp \
 && curl -skL  -H 'Cookie: oraclelicense=accept-securebackup-cookie' \
    https://download.oracle.com/otn-pub/java/jce/8/jce_policy-8.zip > jce_policy-8.zip \
 && unzip jce_policy-8.zip \
 && mv UnlimitedJCEPolicyJDK8/local_policy.jar $JAVA_HOME/lib/security/ \
 && mv UnlimitedJCEPolicyJDK8/US_export_policy.jar $JAVA_HOME/lib/security/ \
 && rm -rf UnlimitedJCEPolicyJDK8/ jce_policy-8.zip \
 && apk del unzip curl

USER ${UID}

WORKDIR /app

CMD ["sh"]
