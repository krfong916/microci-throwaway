# Specify the image that contains the interpreter
FROM node:13.8.0-alpine3.10

LABEL maintainer="Kyle Fong <krfong@ucsc.edu>"

# Create directory in container to hold application files
WORKDIR /app

# Copy package.json of this directory into the container
COPY package.json /app

RUN yarn install

# Copy all files from this directory into the container
COPY . /app

# Set build-time variables
ARG NODE_ENVIRONMENT=dev
ARG PORT=3001

# Set default run-time variables, can be overridden when creating a new container
ENV PORT=${PORT}
ENV NODE_ENVIRONMENT="{NODE_ENVIRONMENT}"

CMD ["yarn", "run", "dev"]