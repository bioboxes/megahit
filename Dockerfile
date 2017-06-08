FROM bioboxes/biobox-minimal-base@sha256:4620e3f97b448560203592a84c58012d4343bdbd81b115d3d66d0690dbb03f7b

ENV MEGAHIT_VERSION v1.1.1

ADD image /usr/local

RUN install.sh && rm /usr/local/bin/install.sh

ENV TASKFILE     /usr/local/share/Taskfile
ENV SCHEMA       /usr/local/share/assembler_schema.yaml
ENV BIOBOX_EXEC  assemble.sh
