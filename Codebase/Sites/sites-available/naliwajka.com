server {
    listen 80 default_server;
    listen 192.168.30.104:80;

    server_name naliwajka.com www.naliwajka.com;

    root /root/naliwajka.com/Codebase/Website;
    index index.html;

    location / {
        try_files $uri $uri/ =404;
    }

    location ~ ^/.well-known/acme-challenge/ {
        root /root/naliwajka.com/Codebase/Website;
        allow all;
    }

    access_log /root/naliwajka.com/logs/naliwajka_access.log;
    error_log  /root/naliwajka.com/logs/naliwajka_error.log;
}
