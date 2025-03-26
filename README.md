# naliwajka.com
Personal website and hosts all my garbage that does not warrant a domain of its own.

### Install:
1) MUST be installed off of root (~). I have hardcoded to be installed to /opt/....
Deal with it
```angular2html
sudo git clone https://github.com/StevenNaliwajka/naliwajka.com /opt/naliwajka.com
```
-----
### Setup:
1) Run setup script
```angular2html
bash setup.sh
```

2) Start website or re-starts website.
```angular2html
bash start-nginx.sh
```
----

### Other CMDs:
- Status: Checks the nginx instance to see if its running.
```angular2html
bash status-nginx.sh
```
- Stop: Stops the nginx instance
```angular2html
bash stop-nginx.sh
```