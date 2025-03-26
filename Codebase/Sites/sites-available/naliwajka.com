server {
    listen 80 default_server;
    server_name _;

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
