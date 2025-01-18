# Use an official Node.js runtime as the base image
FROM node:18-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json to the container
COPY package*.json ./

# Install app dependencies
RUN npm install

# Copy the rest of the app's source code to the container
COPY app.js .

# Expose the port the app will listen on
EXPOSE 8080

# Define the command to run when the container starts
CMD ["node", "app.js"]