# Base image
FROM node:18

# Set working directory
WORKDIR /app

# Copy package files first (for caching)
COPY package*.json ./
COPY client/package*.json ./client/
COPY server/package*.json ./server/

# Install dependencies
RUN npm install
RUN cd client && npm install
RUN cd server && npm install

# Copy the rest of the project files
COPY . .

# Set default env vars (for dev convenience – not secure for production)
ENV MONGO_URI="mongodb://host.docker.internal:27017/webprojectDB"
ENV JWT_SECRET="super_secure_key_123!@#"

# Expose ports for client and server
EXPOSE 3000 
EXPOSE 5000

# Start the app (assumes your dev script runs both client and server)
CMD ["npm", "run", "dev"]