# Base Image
FROM node:18-alpine

# Application directory
WORKDIR /app

# Copy dependencies folder into working directory
COPY package*.json /app/  

# Install requirements 
RUN npm install

# Copy application
COPY . .

# Build the production version of the application
RUN npm run build

EXPOSE 3000

CMD ["npm", "start", "--host=0.0.0.0", "port=3000"]

