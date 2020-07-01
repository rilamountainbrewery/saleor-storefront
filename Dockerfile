FROM node:10.0 as builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
ARG API_URI
ENV API_URI ${API_URI:-https://saleor-backend-dot-rila-dev-281513.ew.r.appspot.com/graphql/}
RUN API_URI=${API_URI} npm run build

FROM nginx:stable
WORKDIR /app
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /app/dist/ /app/
