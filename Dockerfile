# Specify the image that contains the interpreter
FROM node:13.8.0-alpine3.10

LABEL maintainer="Kyle Fong <krfong@ucsc.edu>"

# Create directory in container to hold application files
WORKDIR /app

# Copy package.json of this directory into the container
COPY package.json /app

RUN npm install

# Copy all files from this directory into the container
COPY . /app

# Set build-time variables
ARG NODE_ENV=staging
ARG PORT=3001

# Set default run-time variables, can be overridden when creating a new container
ENV PORT=${PORT}
ENV NODE_ENV="{NODE_ENV}"

CMD ["npm", "run", "staging"]