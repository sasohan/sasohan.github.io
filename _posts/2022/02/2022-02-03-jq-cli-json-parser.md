---
layout: post
title: jq - CLI에서 작동하는 JSON 프로세서(파서)
date: 2022-02-03 11:55:00 +0900
tags:
  - cli
  - json
  - parser
---

`jq`는 커맨드라인에서 `JSON` 데이터를 다룰 일이 있을 때 유용한 툴이다.

- 소스: [stedolan/jq](https://github.com/stedolan/jq)
- 공식 홈페이지: [jq](https://stedolan.github.io/jq/)

공식 홈페이지에서 [OS별로 다운로드](https://stedolan.github.io/jq/download/)를 받을 수 있다. (리눅스, 맥OS, 윈도우, FreeBSD, 솔라리스) (맥에서는 `brew install jq`로 하면 쉽다)

사용법도 쉬운데, 기본적으로 JSON 데이터에 파이프를 연결해서 사용한다.

예를 들어 [https://www.githubstatus.com/api/v2/status.json](https://www.githubstatus.com/api/v2/status.json)의 결과는 다음과 같다.

```json
{
  "page": {
    "id": "kctbh9vrtdwd",
    "name": "GitHub",
    "url": "https://www.githubstatus.com",
    "time_zone": "Etc/UTC",
    "updated_at": "2022-02-02T19:34:39.104Z"
  },
  "status": {
    "indicator": "none",
    "description": "All Systems Operational"
  }
}
```

`jq`를 설치한 상태에서 `page`의 `updated_at` 데이터를 받으려면 다음과 같이 하면 된다.

```sh
curl "https://www.githubstatus.com/api/v2/status.json" | jq '.page.url'
```

이렇게 파싱해서 원하는 프로퍼티만 뽑을 수도 있고, 반복되는 데이터에서 특정한 프로퍼티만 확인할 수도 있다.

- jq 튜토리얼: [https://stedolan.github.io/jq/tutorial/](https://stedolan.github.io/jq/tutorial/)
