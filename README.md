# Docker phpMyAdmin on Alpine 



## Docker run

    docker run \
      --link mysql:mysql \
      --name phpmyadmin \
      -P \
      phpmyadmin

### Environment variables

* `-e PHP_UPLOAD_MAX_FILESIZE=2M`
* `-e PHP_POST_MAX_SIZE=8M`
* `-e PHP_MEMORY_LIMIT=128M`
* `-e PHP_MAX_EXECUTION_TIME=300`

### mod_remoteip.so

By default the HTTP header `X-Forwarded-For` is used in access log
so proxying requests is doable.

For e.g. nginx proxy do:

    location / {
      proxy_pass http://backend;
      proxy_set_header Host $host;
      proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }


## Testing

```shell
docker network create backend

# once
docker run -d --name mysql --net backend -e MYSQL_ROOT_PASSWORD=mysql mysql
# later just
docker start mysql

make test

docker port `docker ps -l -q`
# 80/tcp -> 0.0.0.0:32768
```

Connect to http://localhost:32768/phpmyadmin


## Software

* apache2-2.4.33-r0
* php-apache2-7.1.17-r0
* phpMyAdmin 4.8.2 (from source)

## Release

* `Makefile`: Bump `VERSION`
* `Dockerfile`: Bump `PHPMYADMIN_VERSION` and `RELEASE_DATE`
* `README.md`: Bump versions in `Software` section
* Run `make release`
