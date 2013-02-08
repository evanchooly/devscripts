#! /bin/sh

cvs -n update 2>&1 | egrep "^[CRAM?]" | less
