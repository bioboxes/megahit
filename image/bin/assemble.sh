#!/bin/bash

set -o errexit
set -o nounset
set -o xtrace

READS=$(biobox_args.sh 'select(has("fastq")) | .fastq | map(.value) | join(",")')

TMPDIR=$(mktemp -d)/megahit_out
FLAGS=$(fetch_task_from_taskfile.sh ${TASKFILE} $1)

megahit ${FLAGS} --cpu-only --12 ${READS} --out-dir ${TMPDIR}

cp ${TMPDIR}/final.contigs.fa ${OUTPUT}/contigs.fa
rm -r ${TMPDIR}

cat << EOF > ${OUTPUT}/biobox.yaml
version: 0.9.0
arguments:
  - fasta:
    - id: contigs_1
      value: contigs.fa
      type: contigs
EOF
