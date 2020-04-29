#! /bin/bash

# used to generate cockroach certs

MODE="$1"
ARG_1="$2"
ARG_2="$3"
ARG_3="$4"
if [[ "$MODE" == "ca" ]]; then
    # generate cert/key for the ca
    cockroach cert create-ca --certs-dir="$ARG_1" --ca-key="$ARG_2"
elif [[ "$MODE" == "node" ]]; then
    # generate cert/key for the node
    cockroach cert create-node --certs-dir="$ARG_1" --ca-key="$ARG_2" "$ARG_3"
elif [[ "$MODE" == "client" ]]; then
    # generate cert/key for a user
    cockroach cert create-client --certs-dir="$ARG_1" --ca-key="$ARG_2" "$ARG_3"
else
    echo "[ERROR] invalid cert generation mode"
    echo "generate ca cert: gen_certs.sh ca /path/to/cert/dir /path/to/ca/key/dir/ca.key"
    echo "generate node cert: gen_certs.sh node /path/to/cert/dir /path/to/ca/key/dir/ca.key 127.0.0.1"
    echo "generate client cert: gen_certs client /path/to/cert/dir /path/to/ca/key/dir/ca.key temporal"
    exit 1
fi