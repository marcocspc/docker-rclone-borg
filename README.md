# Docker RClone Borg

A simple container to help me backup my data to Google Drive.

## How to use

### Dependencies

On your host, of course, you'll need to [install Docker](https://docs.docker.com/desktop/install/linux-install/) and [docker-compose](https://docs.docker.com/compose/install/linux/).

Also [install rclone](https://rclone.org/install/) (mandatory to generate config file) and [fuse](https://askubuntu.com/questions/1409496/how-to-install-safely-install-fuse-on-ubuntu-22-04) (make sure driver is loaded, it's safer to just reboot the host after install).

To check whether the drive is loaded:

```
lsmod | grep fuse
```

Output of the above command should not be empty!

You also need to [install `make`](https://askubuntu.com/questions/161104/how-do-i-install-make) for your distribution.

### Using

First, copy the .example files to their respective "non-example" versions:

```
make config-files
```

Or do it manually:

```
cp borgmatic-rclone.env.example borgmatic-rclone.env
cp borgmatic.conf.yaml.example borgmatic.conf.yaml
cp ofelia_config.ini.example ofelia_config.ini
mkdir -p ./rclone
cp rclone.config.example ./rclone/rclone.conf
```

Then edit those files to match your context. `rclone.conf` is present just to show where the file should be located. To really generate one working example, do as follows:

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
