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

```sh
docker run --rm -t --user="$(id -u):$(id -g)" --net=none -v "$(pwd):/data" tex texliveonfly test.tex
```


## Aliasing

```
alias tex='docker run --rm -t --user="$(id -u):$(id -g)" --net=none -v "$(pwd):/data" tex texliveonfly'
```

