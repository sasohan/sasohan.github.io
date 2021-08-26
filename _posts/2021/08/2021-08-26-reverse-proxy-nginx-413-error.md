---
layout: post
title: nginx를 reverse proxy로 이용할 때 413 에러 이유, 해결 방법
date: 2021-08-26 14:53:00 +0900
Tags:
  - nginx
  - Let's Encrypt
  - reverse proxy
  - 413
  - docker
  - docker-compose
---

웹 서버스 설정에 `reverse proxy`를 붙일 때 `nginx`를 많이 사용한다.

예를 들어 기본 웹 서버가 `HTTP` 통신만 가능해 `SSL`을 얹을 때 기능도 많고 무료인 `Let's Encrypt SSL`을 많이들 사용한다. 이 때 기존의 웹 서버에 바로 `Let's Encrypt`를 적용하는 게 아니라 웹 서버 앞에 `reverse proxy` 역할을 하는 `nginx`를 하나 붙이고, 거기에 `Let's Encrypt`를 설정하는 게 좋다.

이렇게 하면 원래 의도한 서버 구조를 수정할 필요 없이 외부의 연결을 받아주는 `nginx(reverse proxy)`에 `SSL`을 얹어 `https` 연결을 확보할 수 있기 때문이다.

이렇게 서버를 이렇게 구성했을 때, 파일을 업로드하면 보통 `413 Request Entity Too Large`가 발생한다. 왜냐면 `nginx`는 기본적으로 `client_max_body_size`가 `1MB`로 설정이 되어 있기 때문이다.

이 때 `reverse proxy` 역할을 하는 `nginx`의 설정에 해당 값을 늘려주면 된다.

```conf
# nginx의 conf 파일 (예: /etc/nginx/conf.d/max_body.conf) 에 다음의 내용을 추가
client_max_body_size 16MB;
```

참고로 기존 서버 구조가 `docker`를 쓰는 환경일 때, `reverse proxy`로 많이 사용하는 게 [`jwilder/nginx-proxy`](https://hub.docker.com/r/jwilder/nginx-proxy)이다. `jwilder/nginx-proxy`도 역시 `client_max_body_size`는 `1MB`로 되어 있다.
