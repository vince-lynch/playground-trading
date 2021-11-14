FROM node:14-alpine

ARG NPM_TOKEN
ENV NPM_TOKEN=${NPM_TOKEN}

WORKDIR /app

COPY package.json package.json
COPY .npmrc .npmrc

# Install ganache-cli globally
RUN npm install -g ganache-cli

#
RUN npm install --save https://npm.pkg.github.com/@vince-lynch/playground-trading@0.1.0
# Set the default command for the image
CMD ["ganache-cli", "--mnemonic", "track mosquito measure very tag diet entry rate peanut tumble rely lion", "-h", "0.0.0.0"]

