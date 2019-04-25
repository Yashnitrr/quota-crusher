FROM node:10

WORKDIR /usr/src/app
COPY . .
RUN npm install --only=prod

EXPOSE 3000

ENTRYPOINT ["node", "index.js"]