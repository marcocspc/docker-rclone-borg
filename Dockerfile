FROM alpine:3.17.3

RUN apk update
RUN apk add \
        rclone \
        borgbackup \
        borgmatic \
        tzdata \
        fuse

RUN mkdir -p /rclone/mount
RUN mkdir -p /data_to_backup
RUN mkdir -p /borgmatic/config

ADD ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]
