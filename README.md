# tmate.io in a docker container


## How to use

Pull docker image:

```bash
docker pull denibertovic/tmate
```

Run container:

```bash
WORKDIR=/path/to/dir docker run --rm -it \
    -v $WORKDIR:/opt/workdir \
    -e LOCAL_USER_ID=$(id -u $USER)
    denibertovic/tmate
    tamte
```

`NOTE`: This will mount the in the `$WORKDIR` that you specify into the docker
container's `/opt/workdir` directoy. That way the user connecting to your session
can only see the filesystem inside the container in that directoy.

Or add something like this to your `~/.zshrc`:

```bash
share-session () {
    if (( $# == 0 ))
    then
        echo Usage: $0 WORKDIR;
    else
        docker run --rm -it -v $1:/opt/workdir -e LOCAL_USER_ID=$(id -u $USER) denibertovic/tmate tmate
    fi;
}
```

and then just run:

```bash
share-session /path/to/shared/dir
```

`NOTE`: once inside run `tmate show-messages` to get a list of ssh connection strings that you can share.

`NOTE`: You can also mount in you `.vim` directory and `.vimrc` file the same way.

## How to build

* run `make build`
* and then `WORKDIR=/path/to/dir make run`

