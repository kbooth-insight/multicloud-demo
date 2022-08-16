FROM   alpine:3


RUN apk add curl \
            bash \
            nodejs \
            npm \
            python3

RUN curl -sSL https://sdk.cloud.google.com | bash

RUN adduser -D demo
WORKDIR /opt/app
COPY . .
RUN npm install

USER demo
CMD ["npm", "start"]

