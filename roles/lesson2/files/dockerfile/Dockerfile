# Reverse Proxy
FROM tksarah/rproxy:latest
MAINTAINER Tk

COPY myproxy /etc/nginx/sites-available/proxy
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
