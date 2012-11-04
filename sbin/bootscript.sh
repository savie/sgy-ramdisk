#!/sbin/busybox.boot sh

SCRIPT_PARTITION=/dev/block/mmcblk0p1
SCRIPT_PATH='.bootscript'
SCRIPT_TMP=/tmp/bootscript
BUSYBOX=/sbin/busybox.boot

bs_init () {
	if [ -b $SCRIPT_PARTITION ]
	then
		$BUSYBOX mkdir /tmp/partition
		$BUSYBOX mount -o ro $SCRIPT_PARTITION /tmp/partition
		if [ -d /tmp/partition/$SCRIPT_PATH ]
		then
			$BUSYBOX mkdir $SCRIPT_TMP
			$BUSYBOX cp -r /tmp/partition/$SCRIPT_PATH/* $SCRIPT_TMP/
		fi
		$BUSYBOX umount /tmp/partition
		$BUSYBOX rmdir /tmp/partition
	fi
}

bs_run_script () {
	BS_SCRIPT=$SCRIPT_TMP/$1
	if [ -f $BS_SCRIPT ]
	then
		$BUSYBOX chmod +x $BS_SCRIPT
		$BS_SCRIPT
	fi
}

bs_system_ro () {
	MOUNT_PARAMS=$($BUSYBOX mount | $BUSYBOX awk '/ \/system / {print "-t "$5" -o remount,ro "$1" /system"}')
	$BUSYBOX mount $MOUNT_PARAMS
}

bs_done () {
	if [ -d /etc/init.d ]
	then
		$BUSYBOX run-parts /system/etc/init.d
	fi
	# $BUSYBOX rm -rf $SCRIPT_TMP
}

case $1 in
	"init")
		bs_init
		bs_run_script init;;
	"post-system")
		bs_run_script post-system;;
	"system-ro")
		bs_system_ro;;
	"post-cache")
		bs_run_script post-cache;;
	"post-data")
		bs_run_script post-data;;
	"done")
		bs_run_script "done"
		bs_done;;
esac
