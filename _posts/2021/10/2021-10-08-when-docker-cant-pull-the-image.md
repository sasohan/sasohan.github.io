---
layout: post
title: docker가 image pull에 실패할 때 (connection refused)
date: 2021-10-07 16:30:00 +0900
tags:
- docker
- connection
- refused
- dns
- 8.8.8.8
---

```sh
Pulling nginx (nginx:latest)...

ERROR: Get https://registry-1.docker.io/v2/: dial tcp: lookup registry-1.docker.io on [::1]:53: read udp [::1]:40562->[::1]:53: read: connection refused
```

리눅스 환경에서 `docker`로  `image`를 받으려고 할 때, 위와 같은 에러가 나면서 받아지지 않을 때 가장 쉽게 해결하는 방법은 DNS 설정 파일에 구글 DNS를 추가해주는 것이다.

```
# DNS 설정 열어서
vi /etc/resolv.conf

# 구글 DNS 추가/저장
nameserver 8.8.8.8
```
