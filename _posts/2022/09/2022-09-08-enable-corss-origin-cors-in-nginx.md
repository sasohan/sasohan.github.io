---
layout: post
title: nginx에서 CORS (Corss-Origin) 설정을 변경하려면
date: 2022-09-08 10:55:00 +0900
tags:
  - nginx
  - cross-origin
  - cors
---

`CORS (Cross-Origin Resource Sharing)`이란 현재 도메인의 리소스를 다른 도메인에서 접근하도록 권한을 설정하도록 브라우저에 알려주는 메커니즘이다.

예를 들어 `http://domain-abc.com`의 자바스크립트에서 `XMLHttpRequest`를 이용해여 `http://domain-def.com/assets/data.json`을 요청할 때 이를 허용할지 말지를 결정하는 것이다.

기본적으로는 다른 도메인으로부터의 리소스 접근 요청을 허용하지 않고, 다른 도메인의 리소스를 접근하지 못하게 되어 있다. 이를 해결하는 방법은 서버마다 다르다.

`nginx`에서는 기본적으로 `Access-Control-Allow-Origin`을 이용해 접근을 허용할 수 있다.

예를 들자면 `nginx.conf`에 다음과 같은 방식으로 구문을 추가하면 된다.

```
server {
  ...
  location / {
    add_header 'Access-Control-Allow-Origin' '*';
    add_header 'Access-Control-Allow-Methods' 'GET, POST, OPTIONS';
    add_header 'Access-Control-Allow-Headers' 'DNT,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type,Range';
    add_header 'Access-Control-Expose-Headers' 'Content-Length,Content-Range';
  }
  ...
}
```

당연하겠지만, `location /` 인지 `location ~* \.(gif|jpg|swf)$` 인지 등은 서버 설정마다 다르다.

위의 예시에서 `'Access-Control-Allow-Origin' '*'`은 모든 도메인에서의 접근을 허용한다는 뜻이고, 만약 도메인을 제한하고 싶다면, `'Access-Control-Allow-Origin' 'http://domain-abc.com'` 등으로 명시하면 된다.

그 아래 항목들도 각각 메소드, 헤더를 명시한 것이므로 상황에 맞게 사용하면 된다.
