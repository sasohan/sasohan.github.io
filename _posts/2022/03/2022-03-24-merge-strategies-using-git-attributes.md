---
layout: post
title: merge할 때 특정 파일을 제외하는 방법
date: 2022-03-24 16:00:00 +0900
tags:
  - git
  - merge
  - attribute
---

`git`으로 `merge`한 후 매번 특정 파일을 돌려놓아야 할 때가 있다. 대표적으로 개발 환경에서 사용하는 파일과 배포 환경에서 사용하는 파일의 내용이 다른 경우다.

예를 들어, `servers.json`이라는 파일이 있는데 `dev` 브랜치에서는 다음과 같고,

```json
{
  "servers": [
    {
      "ip": "192.168.0.33",
      "name": "개발 서버 #1"
    },
    {
      "ip": "192.168.0.44",
      "name": "개발 서버 #2"
    }
  ]
}
```

`prod` 브랜치에서는 다음과 같다고 하자.


```json
{
  "servers": [
    {
      "ip": "123.123.123.1",
      "name": "proxy#1"
    },
    {
      "ip": "123.123.123.2",
      "name": "proxy#1"
    }
  ]
}
```

`dev` 브랜치에서 개발, 테스트를 끝내고, 서비스를 위해 `prod` 브랜치로 개발 소스를 옮긴다고 치자.

```sh
$ git checkout prod
$ git merge dev
```

매번 `merge`할 때마다 `servers.json` 파일의 내용은 테스트 환경 값으로 변경되어 있을 것이고, 상용 서비스를 위해서는 `prod` 브랜치에서 해당 파일의 내용을 다시 상용 서비스에 맞게 수정해줘야 한다.

이 때, `attribute`를 이용하면 `merge`해도 특정 파일의 내용을 유지할 수 있다.

만약 `merge`와 관계 없이 내용을 유지하고 싶은 파일이 `servers.json`이라면 `.gitattributes` 파일 안에 다음처럼 추가한다.

```sh
# .gitattributes 파일이 없다면 만들어서 다음의 내용을 추가
/path/to/servers.json merge=servers
```

그리고, 터미널에서 다음처럼 입력한다.

```sh
$ git config merge.servers.driver true

# 만약 전역으로 설정하려면,
$ git config --global merge.servers.driver true
```

이렇게 하면 `merge`를 실행해도 다음처럼 출력되며 해당 파일은 변경되지 않는다.

```sh
$ git merge dev
Auto-merging servers.json
Merge made by recursive.
```
