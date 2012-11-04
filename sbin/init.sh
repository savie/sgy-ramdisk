#!/system/bin/sh

BUSYBOX=/sbin/busybox.boot
SCRIPT_SYS=/system
SCRIPT_BIN=/system/bin
SCRIPT_INT=/system/etc/init.d

$BUSYBOX mount -o remount,rw -t ext4 /dev/block/stl9 $SCRIPT_SYS
$BUSYBOX mount -o remount,rw -t ext4 / /
$BUSYBOX mount -a

if $BUSYBOX test -d /sdcard ; then
	$BUSYBOX rm -Rf $SCRIPT_BIN/sysinit
	$BUSYBOX rm -Rf $SCRIPT_INT/99complete
	$BUSYBOX touch $SCRIPT_BIN/sysinit
	$BUSYBOX echo "#!$BUSYBOX sh" >> $SCRIPT_BIN/sysinit
	$BUSYBOX echo "" >> $SCRIPT_BIN/sysinit
	$BUSYBOX echo "export PATH=/sbin:/system/sbin:$SCRIPT_BIN:/system/xbin" >> $SCRIPT_BIN/sysinit
	$BUSYBOX echo "$SCRIPT_BIN/logwrapper /system/xbin/run-parts $SCRIPT_INT" >> $SCRIPT_BIN/sysinit
	$BUSYBOX mkdir $SCRIPT_INT
	$BUSYBOX chmod 0755 $SCRIPT_INT
	$BUSYBOX touch $SCRIPT_INT/99complete
	$BUSYBOX echo "#!$BUSYBOX sh" >> $SCRIPT_INT/99complete
	$BUSYBOX echo "" >> $SCRIPT_INT/99complete
	$BUSYBOX echo "sync;" >> $SCRIPT_INT/99complete
	$BUSYBOX echo "setprop cm.filesystem.ready 1;" >> $SCRIPT_INT/99complete
	$BUSYBOX echo "setprop dc.filesystem.ready 1;" >> $SCRIPT_INT/99complete
	$BUSYBOX echo "setprop oxygen.filesystem.ready 1;" >> $SCRIPT_INT/99complete
fi
$BUSYBOX sync

FILESIZE=$($BUSYBOX cat /data/local/Kernel-Ver | $BUSYBOX wc -c)
SIGNATURE="savie@xda"
VERSION="savieSGY-Kernel"

if $BUSYBOX test -d /data/local ; then
	$BUSYBOX mkdir /data/local
fi
$BUSYBOX sync

exec > /data/local/userscript.log 2>&1
$BUSYBOX chown 0.1000 /system/bin/sh
$BUSYBOX rm -R /data/local/Kernel-Ver
$BUSYBOX echo " Starting Logger $VERSION Script " >> /data/local/Kernel-Ver
$BUSYBOX echo " $($BUSYBOX date) " >> /data/local/Kernel-Ver
$BUSYBOX echo "  " >> /data/local/Kernel-Ver
$BUSYBOX echo " $($BUSYBOX cat /proc/version) ">> /data/local/Kernel-Ver
$BUSYBOX echo "  " >> /data/local/Kernel-Ver
/sbin/bmlunlock
$BUSYBOX echo " Unlock BML Blocks " >> /data/local/Kernel-Ver
$BUSYBOX echo "	Mount /System as R/W " >> /data/local/Kernel-Ver
$BUSYBOX mount -o remount,rw -t ext4 $BLOCK/stl9 /system
$BUSYBOX mount -o remount,rw -t ext4 $BLOCK/ /
$BUSYBOX mount -a
$BUSYBOX echo "	Symlink /etc to /system/etc " >> /data/local/Kernel-Ver
$BUSYBOX echo "	Symlink /sdcard to /mnt/sdcard " >> /data/local/Kernel-Ver
$BUSYBOX echo "	Create /sd-ext Folder " >> /data/local/Kernel-Ver
$BUSYBOX echo "	Force Mount the SD-Card " >> /data/local/Kernel-Ver
$BUSYBOX umount /sdcard
$BUSYBOX mount -t vfat -o rw,nosuid,nodev,noexec,uid=1000,gid=1015,fmask=0002,dmask=0002,allow_utime=0020,iocharset=iso8859-1,shortname=mixed,utf8,errors=remount-ro /dev/block/mmcblk0p1 /sdcard
$BUSYBOX sleep 1
$BUSYBOX mount -t vfat -o remount,rw,nosuid,nodev,noexec,uid=1000,gid=1015,fmask=0002,dmask=0002,allow_utime=0020,iocharset=iso8859-1,shortname=mixed,utf8,errors=remount-ro /dev/block/mmcblk0p1 /sdcard
$BUSYBOX sleep 1
$BUSYBOX echo "  " >> /data/local/Kernel-Ver
$BUSYBOX echo " End of Logger $VERSION Script " >> /data/local/Kernel-Ver
$BUSYBOX echo " Regard : $SIGNATURE " >> /data/local/Kernel-Ver
$BUSYBOX echo "	 " >> /data/local/Kernel-Ver
