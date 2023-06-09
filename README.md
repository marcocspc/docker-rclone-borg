# Docker RClone Borg

A simple container to help me backup my data to Google Drive.

## How to use

### Dependencies

On your host, of course, you'll need to [install Docker](https://docs.docker.com/desktop/install/linux-install/) and [docker-compose](https://docs.docker.com/compose/install/linux/).

Also install rclone (mandatory to generate config file) and fuse (make sure driver is loaded, it's safer to just reboot the host after install).

You need to install `make` for your distribution.

### Using

First, copy the .example files to their respective "non-example" versions:

```
make config-files
```

Or do it manually:

```
cp borgmatic-rclone.env.example borgmatic-rclone.env
cp borgmatic.conf.yaml.example borgmatic.conf.yaml
cp crontab.txt.example crontab.txt
```

Then edit those files to match your context. After that generate rclone.conf:

```
make rclone-config
```

Then create the borg repository inside your google drive folder (setup in the .env file):

```
make borg-repo
```

You can then type this to start:

```
make run
```

Or to run in the background:

```
make run-dettached 
```
