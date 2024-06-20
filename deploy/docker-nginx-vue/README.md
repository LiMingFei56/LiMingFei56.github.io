docker cp dist/. nginx-container:/usr/share/nginx/html
docker cp nginx-vue.config nginx-container:/usr/share/nginx
docker exec -it nginx-container /bin/sh

cp /usr/share/nginx/nginx-vue.config /etc/nginx

cp nginx.conf nginx.conf.bak
cp nginx-vue.config nginx.conf

