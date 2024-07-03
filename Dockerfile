# Use an official Node.js runtime as a parent image
FROM node:alpine

# Set the working directory
WORKDIR /usr/src/app

# Install Newman and json-server globally
RUN npm install -g newman json-server

# Copy the Postman collection and environment to the container
COPY collection.json .
COPY env.json .

# Copy the jsonServer directory to the container
COPY jsonServer ./jsonServer

# Expose the port json-server will run on
EXPOSE 3000

# Command to start json-server and then run Newman
CMD ["sh", "-c", "cd jsonServer && json-server --watch data.json & newman run /usr/src/app/collection.json -e /usr/src/app/env.json -r cli,html"]
