# Use the official Ubuntu image
FROM ubuntu:20.04

# Set environment variables to avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Update the apt package list, install curl, gnupg, and dependencies to install Node.js
RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    lsb-release \
    && curl -fsSL https://deb.nodesource.com/setup_16.x | bash - \
    && apt-get install -y nodejs \
    && apt-get clean

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy the package.json and package-lock.json (if available)
COPY package*.json ./

# Install all dependencies (both production and development)
RUN npm install

# Copy the rest of the application files into the container
COPY . .

# Expose the port on which the app will run
EXPOSE 3000

# Command to run the app
CMD ["npm", "start"]

