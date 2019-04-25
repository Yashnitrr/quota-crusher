FROM node:10

WORKDIR /usr/src/app
COPY . .
RUN npm install --only=prod

EXPOSE 5000

ENTRYPOINT ["node", "index.js"]