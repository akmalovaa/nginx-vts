# nginx-vts prometheus

<p align="center">
	<img src="./.github/img/nginx.png">
	<br><br>
  <img src="https://img.shields.io/badge/OS-alpine-0e5980.svg?style=for-the-badge">
	<img src="https://img.shields.io/badge/version-1.27.0-green.svg?style=for-the-badge">
  <img src="https://img.shields.io/badge/size-49MB-blue.svg?style=for-the-badge">
</p>

Simple nginx-vts image updater:
- Auto update current version nginx-alpine 
- VTS module build 
- Trivy scan image for vulnerabilities

**VTS**: Nginx virtual host traffic status module

Main links:
- docker-nginx - https://github.com/nginxinc/docker-nginx
- nginx-module-vts - https://github.com/vozlt/nginx-module-vts

### Commands 

#### pull
```shell
docker pull ghcr.io/akmalovaa/nginx-vts
```

#### or manual build
```shell
git clone https://github.com/akmalovaa/nginx-vts.git .
docker build . -t ghcr.io/akmalovaa/nginx-vts --build-arg VERSION=1.27.0
```

#### run
```shell
docker run -p 80:80 -p 9991:9991 ghcr.io/akmalovaa/nginx-vts
```


### Monitoring

### Prometheus format:

- **Prometheus:** http://localhost:9991/metrics
- **Web:** http://localhost:9991/vts

### Prometheus job config example

```YAML
  - job_name: nginx-vts
    scrape_interval: 15s
    scrape_timeout: 10s
    metrics_path: /metrics
    scheme: http
    static_configs:
      - targets: ['YOUR_IP:9991']
```

[![nginx prometheus](./.github/img/nginx_prometheus.png)](./.github/img/nginx_prometheus.png)


### Grafana dashboards example

https://grafana.com/grafana/dashboards/14824-nginx-vts-stats/

[![nginx grafana](./.github/img/nginx_grafana.png)](./.github/img/nginx_grafana.png)


### Web format example screenshot from the repo [vozlt/nginx-module-vts](https://github.com/vozlt/nginx-module-vts)

[![nginx vts](https://cloud.githubusercontent.com/assets/3648408/23890539/a4c0de18-08d5-11e7-9a8b-448662454854.png)](https://cloud.githubusercontent.com/assets/3648408/23890539/a4c0de18-08d5-11e7-9a8b-448662454854.png)