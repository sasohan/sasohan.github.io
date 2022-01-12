---
layout: post
title: docker로 띄운 phpmyadmin의 업로드 파일 크기 늘이는 방법
date: 2022-01-12 15:10:00 +0900
tags:
  - docker
  - phpmyadmin
  - mysql
  - upload_limit
  - environment variable
---

`phpmyadmin`의 공식 도커 이미지인 [`phpmyadmin/phpmyadmin`](https://hub.docker.com/r/phpmyadmin/phpmyadmin/)을 이용해서 도커 인스턴스를 띄워서 사용할 때, 업로드 파일 크기 제한은 기본적으로 `2MB`로 되어 있다.

이를 늘리려면 환경 변수(`environment variables`) `UPLOAD_LIMIT`을 이용하면 된다.

만약 `docker-compose`를 이용하고, `100MB`로 늘리고 싶은 경우라면 다음과 같다.

```yml
version: "3.1"
services:
  phpmyadmin:
    image: phpmyadmin/phpmyadmin
    environment:
      - UPLOAD_LIMIT=100M
```

도커 단독으로 실행한다면 다음과 같이 `-e` 를 쓰고 지정하면 된다.

```sh
docker run --name myapp \
-e UPLOAD_LIMIT=100M \
-d phpmyadmin/phpmyadmin
```

마지막으로 `phpmyadmin` 도커 버전에서 사용할 수 있는 환경 변수는 공식 리포의 문서를 참고.

- [GitHub - phpmyadmin/docker - Environment variables summary](https://github.com/phpmyadmin/docker#environment-variables-summary)
