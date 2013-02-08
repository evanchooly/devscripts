#! /bin/sh

#changed.sh | grep -v "[#D]" #| cut -c5-
CHANGED=$(changed.sh | grep -v "[#D]" | cut -c5-)

if [ -e copyright.sh ] 
then
	./copyright.sh $CHANGED
else
	copyright.sh $CHANGED
fi
