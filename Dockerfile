# Alpine
FROM pandoc/latex
ENV DEBIAN_FRONTEND noninteractive
ENV TERM=xterm-256color
WORKDIR /data
VOLUME ["/data"]

ENV PYTHONUNBUFFERED=1
RUN apk add --update --no-cache python3 && ln -sf python3 /usr/bin/python
RUN python3 -m ensurepip && pip3 install --no-cache --upgrade pip setuptools

RUN tlmgr init-usertree && tlmgr install texliveonfly
ENTRYPOINT [ ]
