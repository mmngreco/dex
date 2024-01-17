# Latex Docker Image

Binaries avaialabe (among others):

```sh
mktexfmt
mktexlsr
mktexmf
mktexpk
mktextfm
pdflatex
pdftex
tex
texlua
```

## Requirements

- `docker`


## Building

```sh
git clone repo
cd repo
make build
```

## Quickstart

In general I recommend doing this:

```sh
docker run \
    --rm -t \
    --user="$(id -u):$(id -g)" \
    --net=none \
    --volume "$(pwd):/data" \
    tex texliveonfly test.tex
```


### Aliasing

You can add this into your `.bashrc` or `.zshrc`:

```sh
alias tex='docker run --rm -t --user="$(id -u):$(id -g)" --net=none -v "$(pwd):/data" tex texliveonfly'
alias texhere='docker run --rm -ti --user="$(id -u):$(id -g)" --net=none -v "$(pwd):/data" tex /bin/sh'
```

> [!NOTE]
>
> `--user="$(id -u):$(id -g)"` is a magic that fix permission issues when files
> are created with the right permissions and ownership.

After adding those lines into your shell config, you can invoke it as this:

```sh
cd test
tex test.tex
```

