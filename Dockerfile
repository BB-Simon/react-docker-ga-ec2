FROM node:alpine3.18 as build

# Declar built time environment variables
ARG REACT_APP_NODE_ENV  
ARG REACT_APP_SERVER_BASE_URL

# Set environment variables
ENV REACT_APP_NODE_ENV=$REACT_APP_NODE_ENV
ENV REACT_APP_SERVER_BASE_URL=$REACT_APP_SERVER_BASE_URL

# Create app directory
WORKDIR /app
COPY package*.json ./
RUN yarn install
COPY . .
RUN yarn run build

# Serve from nginx
FROM nginx:1.23.3-alpine
WORKDIR /usr/share/nginx/html

RUN rm -rf *

# Copy the build output from the build stage to the nginx web server directory
COPY --from=build /app/build .

EXPOSE 80
ENTRYPOINT ["nginx", "-g", "daemon off;"]
