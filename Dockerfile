# first phase , to build the react app
FROM node:alpine as builder

WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
# dont need to run this container, so just run npm build
RUN npm run build

# after the first step, we have all the stuff we need in /app/build

# second phash, to run the app
FROM nginx
# copy file from different phase, see the ngnix document, it tells us to copy our static file into usr/share//nginx/html
COPY --from=builder /app/build /usr/share/nginx/html
# the default nginx start CMD will start image for us, dont need to specify one