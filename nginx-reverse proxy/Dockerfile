# Base Image
FROM nginx

COPY nginx.conf /etc/nginx/conf.d/default.conf

#COPY ./index.html /usr/share/nginx/html/index.html





EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
# CMD ["nginx", "nginx.exe"] 
#, "--host=0.0.0.0", "--port=80"]
