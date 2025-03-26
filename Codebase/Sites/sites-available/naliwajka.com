server {
    listen 80;
    server_name naliwajka.com www.naliwajka.com;

    root /root/naliwajka.com/Codebase/Website;
    index index.html;

    location / {
        try_files $uri $uri/ =404;
    }

    # Allow the reverse proxy to serve ACME challenge if needed
    location ~ ^/.well-known/acme-challenge/ {
        root /root/naliwajka.com/Codebase/Website;
        allow all;
    }

    access_log /var/log/nginx/naliwajka_access.log;
    error_log  /var/log/nginx/naliwajka_error.log;
}
