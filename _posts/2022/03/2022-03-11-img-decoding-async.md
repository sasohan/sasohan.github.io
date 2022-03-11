---
layout: post
title: img 태그의 이미지 로딩을 비동기로 처리
date: 2022-02-03 11:55:00 +0900
tags:
  - img
  - decoding
  - async
---

`img` 태그에 `decoding` 속성을 `async`로 주면 브라우저가 이미지가 로딩되는 것과 화면의 다른 요소를 그리게 하는 것을 비동기로 처리하게 된다. 반대로 `sync`로 주면 동기로 처리한다.

```html
<img decoding="async" src="/images/last-big-bunny.png" />
```

혹은

```javascript
let img = new Image();
img.decoding = 'async';
img.src = 'images/hero.png';
```

참고로 `decoding` 속성은 세 가지 옵션을 가질 수 있다.

- `sync`: 이미지를 다른 콘텐츠와 동기적으로 인코딩
- `async`: 이미지를 비동기로 인코딩
- `auto`: 브라우저가 적절한 것을 자동으로 고름 (디폴트)

용량이 크면서 당장 이용자가 보는 화면에 보이지 않아도 되는 이미지 엘리먼트에 적절한 방식을 골라 사용하면 효과를 볼 수 있다.

참고로 IE를 제외한 모든 브라우저에서 사용할 수 있다.

- https://developer.mozilla.org/en-US/docs/Web/API/HTMLImageElement/decoding
