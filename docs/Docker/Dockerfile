# Use the official Node.js 14 base image
FROM node:14

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install the application dependencies
RUN npm install

# Copy the application source code to the working directory
COPY . .

# Expose a port that the container will listen on
EXPOSE 3000

# Define the command to run the application
CMD ["npm", "start"]
