FROM node:14

# Create app directory
WORKDIR /bpms

# Install app dependencies
COPY package*.json ./

#install npm package
RUN npm install

# Bundle app source
COPY . .

EXPOSE 8081
EXPOSE 8080
EXPOSE 3000

CMD ["node", "server.js"]
