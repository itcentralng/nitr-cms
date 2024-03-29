FROM node:16-alpine
# Installing libvips-dev for sharp Compatibility
RUN apk update && apk add --no-cache build-base gcc autoconf automake zlib-dev libpng-dev nasm bash vips-dev

ARG PORT
ENV PORT=${PORT}

ARG NODE_ENV
ENV NODE_ENV=${NODE_ENV}

ARG DATABASE_URL
ENV DATABASE_URL=${DATABASE_URL}

ARG ADMIN_USERNAME
ENV ADMIN_USERNAME=${ADMIN_USERNAME}

ARG ADMIN_PASSWORD
ENV ADMIN_PASSWORD=${ADMIN_PASSWORD}

ARG ADMIN_EMAIL
ENV ADMIN_EMAIL=${ADMIN_EMAIL}

ARG NODE_OPTIONS
ENV NODE_OPTIONS=${NODE_OPTIONS}

WORKDIR /opt/
COPY ./package.json ./yarn.lock ./
ENV PATH /opt/node_modules/.bin:$PATH
RUN yarn config set network-timeout 600000 -g && yarn install
WORKDIR /opt/app
COPY ./ .


RUN yarn build

EXPOSE ${PORT}
CMD ["yarn", "start"]
