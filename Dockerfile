FROM node:6

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN apt-get update -y \
  && apt-get install -y --no-install-recommends \
  	curl \
    unzip \
    fontconfig \
    xorg \
    libssl-dev \
    libxrender-dev \
    wget gdebi \
  && rm -rf /var/lib/apt/lists/*

RUN mkdir -p ~/.fonts \
  && cd ~/.fonts \
  && curl -SLO https://noto-website-2.storage.googleapis.com/pkgs/NotoSansCJKsc-hinted.zip \
  && unzip *.zip \
  && rm *.zip \
  && cd - \
  && fc-cache -fv

RUN cd / \
  && curl -SLO https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.4/wkhtmltox-0.12.4_linux-generic-amd64.tar.xz \
  && tar xJf wkhtmltox-0.12.4_linux-generic-amd64.tar.xz \
  && rm *.tar.xz

ENV WKHTMLTOPDF_PATH /wkhtmltox/bin/wkhtmltopdf

ENV NPM_CONFIG_LOGLEVEL warn
RUN npm install -g yarn


