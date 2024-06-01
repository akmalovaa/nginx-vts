# nginx-vts
Auto build actual nginx-vts container image


```shell
docker run -p 80:80 akmalovaa/nginx-vts
```


```shell
docker build . -t akmalovaa/nginx-vts --build-arg VERSION=1.27.0
```