# Base Image
FROM nginx

RUN mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf.disabled

COPY nginx.conf /etc/nginx/conf.d/



EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
