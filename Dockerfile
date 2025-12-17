FROM alpine:3.23.0 as ofelia

RUN apk --no-cache add go gcc musl-dev git

WORKDIR /ofelia
RUN git clone https://github.com/mcuadros/ofelia

WORKDIR /ofelia/ofelia
RUN git checkout 44ac008a34905eb4ceb540a213a2238e4545b4df
RUN go build -o /go/bin/ofelia .

FROM alpine:3.23.0

COPY --from=ofelia /go/bin/ofelia /usr/bin/ofelia

ARG RCLONE_VER="v1.62.2"

RUN	architecture=""; \
	case $(uname -m) in \
		i386)   architecture="386" ;; \
		i686)   architecture="386" ;; \
		x86_64) architecture="amd64" ;; \
		arm*) architecture="arm-v6" ;; \
		aarch64) architecture="arm-v6" ;; \
	esac ; \
    echo "https://downloads.rclone.org/$RCLONE_VER/rclone-$RCLONE_VER-linux-$architecture.zip" > /tmp/rclone_url
    

RUN apk update
RUN apk add \
        borgbackup \
        borgmatic \
        tzdata \
        unzip \
        wget \
        fuse3

RUN wget $(cat /tmp/rclone_url) -O /rclone.zip
RUN unzip /rclone.zip
RUN mv /rclone*/rclone /usr/bin/rclone
RUN rm -rf /rclone

RUN mkdir -p /rclone/mount
RUN mkdir -p /data_to_backup
RUN mkdir -p /borgmatic/config

ADD ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]
