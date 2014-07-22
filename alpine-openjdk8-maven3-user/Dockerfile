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

# Build image (example)
# $ docker build --force-rm -t maven ./
# $ docker build --force-rm -build-arg UID=$(id -u) -t maven ./
# Verify (removes the container immediately):
# $ docker run --rm -it maven java -version
# $ docker run --rm -it maven mvn --version
# $ docker run --rm -it -v ~/.m2:/home/maven/.m2 maven ls -hAlF /home/maven/.m2
# 
# Now build your local project with containerized Maven!
# $ cd <path-to-your-pom.xml>
# $ docker run --rm -it -v ~/.m2:/home/maven/.m2 -v $(pwd):/project maven mvn clean test install
# 
# Use an alias for your containerized Maven!
# $ alias cmvn='docker run --rm -it -v ~/.m2:/home/maven/.m2 -v $(pwd):/project maven mvn'
# $ cmvn --version
# $ cmvn clean test install

FROM openjdk:8-alpine
MAINTAINER Dittmar Steiner <dittmar.steiner@gmail.com>

ENV MAVEN_VERSION 3.3.9

ENV MAVEN_HOME /usr/share/maven
ENV JAVA_TOOL_OPTIONS '-Dfile.encoding=UTF8 -Dsun.jnu.encoding=UTF-8'
ENV LANG C.UTF-8

ENV USERNAME=maven
ARG UID=1000

RUN adduser -D -u ${UID} ${USERNAME} \
 && mkdir -p /project \
 && chown ${USERNAME} /project \
 && cd /tmp \ 
 && apk --update add curl gpgme unzip \
 && curl -sS https://www.apache.org/dist/maven/KEYS > KEYS \
 && gpg --import KEYS \
 && curl -sS https://www.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz.asc > asc \
 && curl -sSL http://www-eu.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz > apache-maven-$MAVEN_VERSION-bin.tar.gz \
 && gpg --verify asc apache-maven-$MAVEN_VERSION-bin.tar.gz \
 && if [ $? != 0 ]; then echo 'ERROR: signature not valid!'; exit 1; fi \
 && tar xf apache-maven-$MAVEN_VERSION-bin.tar.gz \
 && mv apache-maven-$MAVEN_VERSION maven \
 && mv maven /usr/share \
 && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn \
 && mvn --version \
 && if [ $? != 0 ]; then echo 'ERROR: Maven not installed successfully!'; exit 2; fi \
 && rm asc KEYS apache-maven-$MAVEN_VERSION-bin.tar.gz \
 && curl -skL  -H 'Cookie: oraclelicense=accept-securebackup-cookie' \
    https://download.oracle.com/otn-pub/java/jce/8/jce_policy-8.zip > jce_policy-8.zip \
 && unzip jce_policy-8.zip \
 && mv UnlimitedJCEPolicyJDK8/local_policy.jar $JAVA_HOME/jre/lib/security/ \
 && mv UnlimitedJCEPolicyJDK8/US_export_policy.jar $JAVA_HOME/jre/lib/security/ \
 && rm -rf UnlimitedJCEPolicyJDK8/ jce_policy-8.zip \
 && apk -q del unzip gpgme curl \
 && echo && echo "Maven $MAVEN_VERSION installed sucessfullfy." && echo

USER ${UID}

VOLUME /home/${USERNAME}/.m2
VOLUME /project

WORKDIR /project

CMD ["mvn"]
