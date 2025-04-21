# Use an official Node.js runtime as a parent image
FROM node:18-alpine

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json (or yarn.lock)
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Make port 5173 available to the world outside this container
EXPOSE 5173

# Define environment variable for the API URL (can be overridden)
ENV REACT_APP_API_URL=http://api:8000

# Run the app when the container launches
CMD ["npm", "run", "dev", "--", "--host", "0.0.0.0"] 