all: sr0 sr1 sr2 sr3

sr0:
	screen -d -m -S sr0 bash backup.sh /dev/sr0 /mnt/dvds/

sr1:
	screen -d -m -S sr1 bash backup.sh /dev/sr1 /mnt/dvds/

sr2:
	screen -d -m -S sr2 bash backup.sh /dev/sr2 /mnt/dvds/

sr3:
	screen -d -m -S sr3 bash backup.sh /dev/sr3 /mnt/dvds/
