#!/bin/ash

cp /usr/share/zoneinfo/$TZ /etc/timezone
echo $TZ > /etc/timezone
echo "Current date is $(date)."

echo "Mounting \"$REMOTE:$PATH_TO_FILES\" using rclone in the backgroud."
/usr/bin/rclone mount "$REMOTE:$PATH_TO_FILES" /rclone/mount --daemon

echo "Files inside rclone mount are:"
ls -l /rclone/mount

echo "Starting crond."
/usr/sbin/crond -f -l 2 -L /dev/stdout
