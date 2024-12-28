FROM node:alpine3.18 as build

# Create app directory
WORKDIR /app
COPY package*.json yarn.lock ./
RUN yarn install
COPY . .
RUN yarn run build

# Serve from nginx
FROM nginx:1.23-alpine
WORKDIR /usr/share/nginx/html

RUN rm -rf *

# Copy the build output to replace the default nginx contents.
COPY --from=build /app/build .

EXPOSE 80

ENTRYPOINT ["nginx", "-g", "daemon off;"]
