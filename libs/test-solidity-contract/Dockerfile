FROM node:14.18.0-alpine
RUN apk --no-cache add git

ARG NPM_TOKEN
ENV NPM_TOKEN=${NPM_TOKEN}
ENV NODE_ENV=dev
ENV NODE_PATH=/usr/local/lib/node_modules
RUN rm -rf /usr/local/lib/node_modules/.staging/*

WORKDIR /usr/src/app
RUN npm install -g ethereum-waffle@^3.4.0

COPY package.json package.json
RUN printf '\n\
  always-auth=true\n\
  @vince-lynch:registry=https://npm.pkg.github.com\n\
  //npm.pkg.github.com/:_authToken=${NPM_TOKEN}\n\
  '\
  > .npmrc

# Install ganache-cli globally
RUN npm install -g ganache-cli

## Install solidity contracts
#
RUN npm install

WORKDIR /usr/src/app/node_modules/@vince-lynch/playground-trading/

## Install dev dependencies
#
RUN npm i \
  #ethereum-waffle@^3.4.0 \
  @nomiclabs/hardhat-ethers@^2.0.2 \
  @nomiclabs/hardhat-waffle@^2.0.1 \
  @nomiclabs/hardhat-web3@^2.0.0 \
  @remix-project/remixd@^0.5.2 \
  chai@^4.3.4 \
  ethers@^5.4.1

## Write deployment secrets file
#
RUN printf '\n\
{\n\
  "ALCHEMY_API_KEY":"<ALCHEMY_API_KEY>",\n\
  "PRIVATE_KEY":"<PRIVATE_KEY>",\n\
  "MNEMONIC":"<MNEMONIC>"\n\
}'\
  > secrets.json

## Set test script as default command
#
#CMD ["npx", "hardhat", "test"]

# Set the default command for the image
#CMD ["ganache-cli", "--mnemonic", "track mosquito measure very tag diet entry rate peanut tumble rely lion", "-h", "0.0.0.0"]

