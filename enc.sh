#!/bin/bash
#########################################################################
# Author: 8100d1r0n
# E-mail: echo  ODEwMGQxcjBuKGF0KXJpc2V1cChkb3QpbmV0Cg==|base64 -d
# Created Time: 2016-08-24T03:23:20+0300
# File Name: enc.sh
#########################################################################
usage() {
    echo -e "Usage:\n\t./`basename $0` -e ScriptFile\n" \
            "\t./`basename $0` -r EncryptFile"
}
if [ -z "$1" ]
then
    usage
    exit 1;
fi
while [ $# -gt 0 ]
do
    case "$1" in
        -r|--run)
            openssl enc -d -aes-256-cbc -a -in "$2" | bash -
            exit 1;
            ;;
        -e|--encrypt)
            openssl enc -e -aes-256-cbc -a -in "$2" -out "$2.enc"
            exit 1;
            ;;
        -h|--help)
            usage
            exit 1;
            ;;
        esac
    done
