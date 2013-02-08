#! /bin/sh

DIR=/Users/jlee/Pictures/bg-archives 
FILES=`ls -atr ${DIR} | grep -v "\.$" | tail -n 20`
cd ${DIR}
rsync -rv --delete ${FILES} ../Backgrounds/

