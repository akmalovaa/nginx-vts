# nginx-vts prometheus

Auto build actual nginx-alpine + vts module container image

Links:
- docker-nginx - https://github.com/nginxinc/docker-nginx
- ginx-module-vts - https://github.com/vozlt/nginx-module-vts



### Commands 

#### pull
```shell
docker pull ghcr.io/akmalovaa/nginx-vts:1.27.0
```

#### or build
```shell
git clone https://github.com/akmalovaa/nginx-vts.git .
docker build . -t ghcr.io/akmalovaa/nginx-vts:1.27.0 --build-arg VERSION=1.27.0
```

#### run
```shell
docker run -p 80:80 -p 9991:9991 ghcr.io/akmalovaa/nginx-vts:1.27.0
```


