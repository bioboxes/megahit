#FROM debian:wheezy
FROM ubuntu:14.10
MAINTAINER Michael Barton, mail@michaelbarton.me.uk

ENV PACKAGES wget make python g++ zlib1g-dev bc xz-utils

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends ${PACKAGES}
    
# Locations for biobox file validator
ENV BASE_URL  https://s3-us-west-1.amazonaws.com/bioboxes-tools/validate-biobox-file
ENV VERSION   0.x.y
ENV VALIDATOR /biobox-validator

# Install the biobox file validator
RUN mkdir ${VALIDATOR}
RUN wget \
      --quiet \
      --no-check-certificate \
      --output-document - \
      ${BASE_URL}/${VERSION}/validate-biobox-file.tar.xz \
    | tar xJf - \
      --directory ${VALIDATOR} \
      --strip-components=1
      
ENV PATH ${PATH}:${VALIDATOR}

RUN wget \
    --output-document /schema.yaml \
    --no-check-certificate \
    https://raw.githubusercontent.com/bioboxes/rfc/master/container/short-read-assembler/input_schema.yaml

# Get tool
ENV MEGAHIT_DIR /tmp/megahit
ENV MEGAHIT_TAR https://github.com/voutcn/megahit/archive/v0.1.2.tar.gz

RUN mkdir ${MEGAHIT_DIR}
RUN cd ${MEGAHIT_DIR} &&\
    wget --no-check-certificate ${MEGAHIT_TAR} --output-document - |\
    tar xzf - --directory . --strip-components=1 &&\
    make

ENV CONVERT https://github.com/bronze1man/yaml2json/raw/master/builds/linux_386/yaml2json
RUN cd /usr/local/bin && wget --quiet --no-check-certificate ${CONVERT} && chmod u+x yaml2json

ENV JQ http://stedolan.github.io/jq/download/linux64/jq
RUN cd /usr/local/bin && wget --quiet --no-check-certificate ${JQ} && chmod u+x jq

ADD Procfile /
ADD run /usr/local/bin/
ADD entry /usr/local/bin/

RUN chmod u+x /usr/local/bin/run
RUN chmod u+x /usr/local/bin/entry

ADD Taskfile /

ENTRYPOINT ["entry"]
