#!/bin/ash

cp /usr/share/zoneinfo/$TZ /etc/timezone
echo $TZ > /etc/timezone
echo "Current date is $(date)."

echo "Mounting \"$REMOTE:$PATH_TO_FILES\" using rclone in the backgroud."
/usr/bin/rclone mount "$REMOTE:$PATH_TO_FILES" /rclone/mount &

while ! grep -qs '/rclone/mount ' /proc/mounts ; do
    echo "Waiting for rclone to mount /rclone/mount"
    sleep 1
done

echo "Files inside rclone mount are:"
ls -l /rclone/mount

echo "Starting ofelia. (crond replacement)"
ofelia daemon --config=/ofelia_config.ini
