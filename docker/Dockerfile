FROM nginx

RUN apt-get -y update

COPY nginx/nginx.conf /etc/nginx
COPY nginx/default.conf /etc/nginx/conf.d

RUN chown -R nginx:nginx /var/cache/nginx && \
        chown -R nginx:nginx /var/log/nginx && \
        chown -R nginx:nginx /etc/nginx/conf.d && \
        chmod -R 766 /var/log/nginx/

RUN touch /var/run/nginx.pid && \
    chown -R nginx:nginx /var/run/nginx.pid

USER nginx

COPY --chown=nginx:nginx image /usr/share/nginx/html

EXPOSE 8080

CMD ["nginx","-g","daemon off;"]
