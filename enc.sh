#!/bin/bash
#########################################################################
#   Author: 8100d1r0n
#   E-mail: echo  ODEwMGQxcjBuKGF0KXJpc2V1cChkb3QpbmV0Cg== | base64 -d
#  Created: 2016-08-24  T 03:23
# Revision: 2017-03-15  T 16:15
# FileName: enc.sh
#########################################################################
<<EXAMPLE
 $ ./enc.sh --encrypt test.sh
enter aes-256-cbc encryption password: test
Verifying - enter aes-256-cbc encryption password: test
 $ ./enc.sh --run  test.sh.enc
enter aes-256-cbc decryption password: test
test
 $ file test.sh.enc
test.sh.enc: openssl enc'd data with salted password, base64 encoded

EXAMPLE
<<LICENSE
        DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
                Version 2, December 2004

Copyright 2016 8100d1r0n

Everyone is permitted to copy and distribute verbatim or modified
copies of this license document, and changing it is allowed as long
as the name is changed.

        DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION

 0. You just DO WHAT THE FUCK YOU WANT TO.
LICENSE
progname=${0##*/}

usage() {
cat <<USAGE
Usage:
        ${progname} -e ScripFile
        ${progname} -r EncryptFile
USAGE
}
if [ -z "$1" ];then
    usage
    exit
fi
while [ $# -gt 0 ]; do
    case "$1" in
        -r|--run)
            openssl enc -d -aes-256-cbc -a -in "$2" | bash -
            exit 0;;
        -e|--encrypt)
            openssl enc -e -aes-256-cbc -a -in "$2" -out "$2.enc"
            exit 0;;
        -h|--help)
            usage
            exit 0;;
        *)
            usage
            exit 1;;
        esac
    done
