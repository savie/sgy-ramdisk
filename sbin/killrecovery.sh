#!/system/bin/sh

BUSYBOX=/sbin/busybox.boot

$BUSYBOX mkdir -p /sd-ext
$BUSYBOX rm /cache/recovery/command
$BUSYBOX rm /cache/update.zip
touch /tmp/.ignorebootmessage
kill $(ps | grep /sbin/adbd)
kill $(ps | grep /sbin/recovery)

# On the Galaxy S, the recovery comes test signed, but the
# recovery is not automatically restarted.
if [ -f /init.smdkc110.rc ]
then
    /sbin/recovery &
fi

# Droid X
if [ -f /init.mapphone_cdma.rc ]
then
    /sbin/recovery &
fi

/sbin/recovery &

exit 1
