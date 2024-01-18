# Docker Latex Image (aka dex)


[![Static Badge](https://img.shields.io/badge/docker-hub-blue?style=flat-square)](https://hub.docker.com/r/mmngreco/dex)


This Docker image is based on the `pandoc/latex` image, which is essentially an
Alpine Linux machine with a TeX Live installation (including pandoc). I have
extended it with the `texliveonfly` package.

Here are the LaTeX-related binaries available (among others) in the Docker
image:

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
texliveonfly  # see notes
xelatex
xetex
```


> [!NOTE]
>
> texliveonfly will install missed dependencies if they are missed in the
> container based on the `.tex` file.

## References

- https://www.ctan.org/pkg/texliveonfly
- https://hub.docker.com/r/pandoc/latex

## Requirements

- `docker`


## Building

```sh
git clone https://github.com/mmngreco/dex
cd dex
make build
```

## Quickstart

In general, I recommend doing this:

```sh
docker run \
    --rm -t \
    --user="$(id -u):$(id -g)" \
    --net=none \
    --volume "$(pwd):/data" \
    --name $(basename $PWD) \
    mmngreco/dex texliveonfly test.tex
```


### Aliasing

You can add this to your `.bashrc` or `.zshrc` for your convenience:

```bash
# non-interactive (cli)
alias dex='docker run --rm -t --user="$(id -u):$(id -g)" --net=none -v "$(pwd):/data" mmngreco/dex'

# interactive
alias dexi='docker run --rm -t -i --user="$(id -u):$(id -g)" --net=none -v "$(pwd):/data" mmngreco/dex'

# binary alias
alias dexliveonfly='dex texliveonfly'
alias dexpdf='dex pdftex'
```

> [!NOTE]
>
> `--user="$(id -u):$(id -g)"` is a magic that fixes permission issues when
> files are created in a volume by a container. This code snippet ensures that
> files are created with the correct permissions and ownership.

After adding those lines to your shell config, you can invoke it like this:

```sh
cd test
dexliveonfly test.tex
dexpdf test.tex
```

## Executables


Alternatively, you can create some executables (bash script with execution
permission) to call the `dex` command from anywhere. Sometimes, we need to call
it from a terminal that isn't using our profile (doesn't load our
`.bashrc`/`.zshrc`). In that case, you can create some files under the
`~/.local/bin/` folder, which should be on your path, and this will allow you
to execute the command.

Here are some examples:

```bash
echo '#!/usr/bin/env bash' > ~/.local/bin/dex
echo 'docker run --rm -t --user="$(id -u):$(id -g)" --net=none -v "$PWD:$PWD" -w $PWD mmngreco/dex $@' >> ~/.local/bin/dex
sudo chmod +x ~/.local/bin/dex

echo '#!/usr/bin/env bash' > ~/.local/bin/dexi
echo 'docker run --rm -t -i --user="$(id -u):$(id -g)" --net=none -v "$PWD:$PWD" -w $PWD mmngreco/dex $@' > ~/.local/bin/dexi
sudo chmod +x ~/.local/bin/dexi

# optionally
echo '#!/usr/bin/env bash' > ~/.local/bin/dexliveonfly
echo 'dex texliveonfly' > ~/.local/bin/dexliveonfly
sudo chmod +x ~/.local/bin/dexliveonfly

echo '#!/usr/bin/env bash' > ~/.local/bin/dexpdf
echo 'dex pdftex' > ~/.local/bin/dexpdf
sudo chmod +x ~/.local/bin/dexpdf
```


> [!NOTE]
>
> If, for some reason, `.local/bin` is not in the path, you can add it to the
> path or call the script using its absolute file name.

This allows us to use those scripts from everywhere. Test it by simply
reloading your shell and calling `dexpdf --help`.

```bash
dexpdf --help
~/.local/bin/dexpdf --help
/home/user/.local/bin/dexpdf --help
```
## LivePreview

This feature only works using the mentioned executables above.

### Vim/Neovim

```vimscript
augroup Latex
  au!
  au BufWritePost *.tex silent !dex pdflatex % && firefox %:t:r.pdf
augroup end
```


### VSCode

Install [LaTeX Workshop][vs-ext] extension.

Add the following into your `settings.json`

```json
    "latex-workshop.latex.outDir": "%DIR%",
    "latex-workshop.latex.recipes": [
        {
          "name": "dex",
          "tools": [
            "pdflatex"
          ]
        },
      ],
    "latex-workshop.latex.tools": [
        {
          "name": "pdflatex",
          "command": "dex",
          "args": [
            "pdflatex",
            "%DOC%",
            "-output-directory=%OUTDIR%"

          ],
          "env": {"PWD": "%OUTDIR%"}
        },
        {
          "name": "bibtex",
          "command": "dex",
          "args": [
            "bibtex",
            "%DOCFILE%"
          ],
          "env": {"PWD": "%OUTDIR%"}
        }
    ],
```

[vs-ext]: https://marketplace.visualstudio.com/items?itemName=James-Yu.latex-workshop
