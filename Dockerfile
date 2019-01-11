FROM node:8.15.0-alpine AS builder

WORKDIR /usr/src/app

COPY ./package.json ./
COPY ./.babelrc ./
COPY ./.env ./
COPY ./.eslintrc.js ./
COPY ./.eslintignore ./
COPY ./src ./src

RUN yarn install
RUN yarn build


## stage 2

FROM node:8.15.0-alpine

WORKDIR /usr/src/app

COPY --from=builder ./lib .
COPY --from=builder ./.env .

CMD ["node", "index.js"]