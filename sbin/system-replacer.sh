#!/system/bin/sh

BUSYBOX=/sbin/busybox.boot
SCRIPT_SRP=/sdcard/.system-replacer
SCRIPT_SYS=/system

$BUSYBOX mount -o remount,rw -t ext4 /dev/block/stl9 $SCRIPT_SYS
$BUSYBOX mount -o remount,rw -t ext4 / /
$BUSYBOX mount -a

if $BUSYBOX test -d $SCRIPT_SRP ; then
	$BUSYBOX mkdir $SCRIPT_SRP
fi
$BUSYBOX sync

$BUSYBOX umount /sdcard
$BUSYBOX mount -t vfat -o rw,nosuid,nodev,noexec,uid=1000,gid=1015,fmask=0002,dmask=0002,allow_utime=0020,iocharset=iso8859-1,shortname=mixed,utf8,errors=remount-ro /dev/block/mmcblk0p1 /sdcard
$BUSYBOX sleep 1

$BUSYBOX mount -t vfat -o remount,rw,nosuid,nodev,noexec,uid=1000,gid=1015,fmask=0002,dmask=0002,allow_utime=0020,iocharset=iso8859-1,shortname=mixed,utf8,errors=remount-ro /dev/block/mmcblk0p1 /sdcard
$BUSYBOX sleep 1

if $BUSYBOX test -d /sdcard ; then
	$BUSYBOX cp -R $SCRIPT_SRP/* $SCRIPT_SYS/
	$BUSYBOX rm -Rf $SCRIPT_SRP
	$BUSYBOX chown 0.0 $SCRIPT_SYS/*
	$BUSYBOX chmod 0644 $SCRIPT_SYS/app/*
	$BUSYBOX chmod 0755 $SCRIPT_SYS/bin/*
	$BUSYBOX chmod 0777 $SCRIPT_SYS/etc/init.d/*
	$BUSYBOX chmod 0644 $SCRIPT_SYS/framework/*
	$BUSYBOX chmod 0644 $SCRIPT_SYS/lib/modules/*
	$BUSYBOX chmod 6755 $SCRIPT_SYS/xbin/*
	$BUSYBOX rm $SCRIPT_SYS/ReadMe
	$BUSYBOX mkdir $SCRIPT_SRP
	$BUSYBOX mkdir $SCRIPT_SRP/app
	$BUSYBOX mkdir $SCRIPT_SRP/bin
	$BUSYBOX mkdir $SCRIPT_SRP/etc
	$BUSYBOX mkdir $SCRIPT_SRP/etc/init.d
	$BUSYBOX mkdir $SCRIPT_SRP/framework
	$BUSYBOX mkdir $SCRIPT_SRP/lib
	$BUSYBOX mkdir $SCRIPT_SRP/lib/modules
	$BUSYBOX mkdir $SCRIPT_SRP/xbin
	$BUSYBOX touch $SCRIPT_SRP/ReadMe
	$BUSYBOX echo "SYSTEM-REPLACER savieKernel" >> $SCRIPT_SRP/ReadMe
	$BUSYBOX echo "system-replacer features is to add/replace file into system" >> $SCRIPT_SRP/ReadMe
	$BUSYBOX echo "inspiring from maroc-os@xda and modified by savie@xda" >> $SCRIPT_SRP/ReadMe
	$BUSYBOX echo " " >> $SCRIPT_SRP/ReadMe
	$BUSYBOX echo "List of folder to put file:" >> $SCRIPT_SRP/ReadMe
	$BUSYBOX echo "- $SCRIPT_SRP/app" >> $SCRIPT_SRP/ReadMe
	$BUSYBOX echo "- $SCRIPT_SRP/bin" >> $SCRIPT_SRP/ReadMe
	$BUSYBOX echo "- $SCRIPT_SRP/etc/init.d" >> $SCRIPT_SRP/ReadMe
	$BUSYBOX echo "- $SCRIPT_SRP/framework" >> $SCRIPT_SRP/ReadMe
	$BUSYBOX echo "- $SCRIPT_SRP/lib/modules" >> $SCRIPT_SRP/ReadMe
	$BUSYBOX echo "- $SCRIPT_SRP/xbin" >> $SCRIPT_SRP/ReadMe
	$BUSYBOX echo " " >> $SCRIPT_SRP/ReadMe
	$BUSYBOX echo "Note: " >> $SCRIPT_SRP/ReadMe
	$BUSYBOX echo "- $SCRIPT_SRP/etc/init.d/99complete --> 99complete will add/replace into $SCRIPT_SYS/etc/init.d after rebooting" >> $SCRIPT_SRP/ReadMe
	$BUSYBOX echo "- to add/replace deodex rom from odex rom in $SCRIPT_SYS/app and $SCRIPT_SYS/framework make sure to delete *.odex file first before rebooting" >> $SCRIPT_SRP/ReadMe
	$BUSYBOX echo "- $SCRIPT_SRP/app/Browser.apk --> you must delete $SCRIPT_SYS/app/Browser.odex before rebooting" >> $SCRIPT_SRP/ReadMe
	$BUSYBOX echo "- this features will automatic fix-permission after reboot but if permission not valid just change manually with rootexplorer" >> $SCRIPT_SRP/ReadMe
	$BUSYBOX echo "" >> $SCRIPT_SRP/ReadMe
fi
$BUSYBOX sync

$BUSYBOX umount /sdcard
$BUSYBOX sync
