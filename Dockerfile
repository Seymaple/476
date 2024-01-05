FROM node:14-alpine as build
WORKDIR /home/node/app
RUN apk add --no-cache git
RUN yarn global add polymer-cli@1.9.11
COPY package.json package.json
RUN yarn install
COPY . .
RUN yarn build
CMD [ "yarn", "build" ]

FROM nginx as prod
COPY --from=build /home/node/app/_site /usr/share/nginx/html