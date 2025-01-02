FROM node:16-alpine AS build

WORKDIR /usr/src/app

COPY package*.json ./
RUN npm install

COPY . .

FROM node:16-alpine

WORKDIR /usr/src/app

COPY --from=build /usr/src/app /usr/src/app

RUN npm install --only=production

EXPOSE 3000

CMD ["npm", "start"]

