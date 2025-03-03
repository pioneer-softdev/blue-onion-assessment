# Use the correct Node.js version
FROM node:20

# Set working directory
WORKDIR /app

# Copy package.json and install dependencies
COPY package.json ./
RUN npm install

# Copy the rest of the frontend
COPY . .

# Expose port
EXPOSE 5173

# Start the frontend server
CMD ["npm", "run", "dev"]
