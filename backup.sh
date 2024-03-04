#!/bin/bash

# get arguments for target dir and drive
DISC_DRIVE=$1
if [[ -z "$DISC_DRIVE" ]]; then
   echo "Please use first argument for disc drive"
   exit 1
fi

BASE_TARGET_DIR=$2
if [[ -z "$BASE_TARGET_DIR" ]]; then
   echo "Please use second argument as target directory"
   exit 1
fi


BLKID_CMD=/usr/sbin/blkid
EJECT_CMD=/usr/bin/eject
BEEP_CMD=/usr/bin/beep
DVDBACKUP_CMD=/usr/bin/dvdbackup

echo "Start Loop"

while true;
do
	echo "Waiting for device"
	TITLE=''
	while [[ -z "$TITLE" ]];
	do
		# use block ID to check if there's a disc inserted
		TITLE=$($BLKID_CMD "$DISC_DRIVE" | sed 's/.* LABEL="\(.*\)" BLOCK_SIZE.*/\1/i');
		# /dev/sr1: UUID="3b6681d600000000" LABEL="HEROES" BLOCK_SIZE="2048" TYPE="udf"
		sleep 1
	done

	#get image name, add random stuff at the end
	RAND=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 5; echo);
	TARGET_DIR=${BASE_TARGET_DIR}/${TITLE}_${RAND}
	echo "${TARGET_DIR}"
	mkdir -p "${TARGET_DIR}"
	
	${DVDBACKUP_CMD} --mirror --input="${DISC_DRIVE}" --output="${TARGET_DIR}"
	
	${EJECT_CMD} "${DISC_DRIVE}"
	${BEEP_CMD}
	
done
