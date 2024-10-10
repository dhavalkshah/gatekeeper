FROM node:20.17.0
WORKDIR /app/auth

COPY . /app/auth

RUN npm install 

ENV ENABLE_DS_AUTOUPDATE=true

EXPOSE 3001

CMD ["node", "app.js"]
