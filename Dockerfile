FROM ubuntu:18.04

WORKDIR /home/

RUN apt-get update -y \
&& apt-get upgrade -y \
&& apt-get dist-upgrade -y \
&& apt-get autoremove -y \
&& apt-get autoclean -y \
&& apt-get install -y unzip \
&& apt-get install lsof \
&& apt-get install nano

ARG DEBIAN_FRONTEND=noninteractive
ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH
RUN apt-get update \
    && apt-get install -y tzdata \
    && apt-get -y upgrade && apt-get install -y build-essential curl wget git vim libboost-all-dev

SHELL ["/bin/bash", "--login", "-i", "-c"]
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.36.0/install.sh | bash
RUN nvm install 12.14.1 \
&& nvm alias default 12.14.1 \
&& nvm use default 

RUN npm install -y --global yarn

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

RUN rustup toolchain install nightly-2020-07-12 \
&& rustup default nightly-2020-07-12-x86_64-unknown-linux-gnu \
&& rustup target add wasm32-unknown-unknown --toolchain nightly-2020-07-12

RUN wget https://github.com/polkadot-js/apps/archive/v0.46.1.zip \
&& unzip v0.46.1.zip

ADD run.sh /home/
RUN chmod +x run.sh
RUN ./run.sh

RUN git --version \
&& curl --version \
&& node --version \
&& npm --version \
&& yarn --version \
&& rustup --version \
&& rustup show

EXPOSE 3000

CMD ["yarn", "start"]
# CMD ["yarn", "start", "&"]
# CMD ["nohup", "yarn", "start", "&"]
# CMD ["bash", "run.sh"]
