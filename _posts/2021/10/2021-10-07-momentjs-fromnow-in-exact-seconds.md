---
layout: post
title: moment.js의 fromNow()에서 초 단위까지 정확하게 카운팅하려면
date: 2021-10-07 16:30:00 +0900
tags:
- moment.js
- fromNow
- relative time
---

`moment.js`는 자바스크립트에서 시간 관련 처리를 쉽게 하도록 도와주는 라이브러리이며, `.fromNow()`라는 메소드로 시간을 상대적으로 표시해주는데 유용하다.

그런데, 이 때 1분 이내는 '몇 초' 혹은 `a few seconds ago` 정도로 표시를 할 뿐, 정확하게 초를 알려주지 않는다.

이것은 기본적으로 `moment.js`에서 사람이 읽기 쉽게 처리하느라 그런 건데, 예를 들어 46초, 52초, 33초 이렇게 보여주느니 그냥 '1분 이내'라고 표현하는 게 눈에 더 잘 들어오기 때문이다.

그런데, 만약 정확하게 원하는 초를 보여주고, 심지어 이걸 초마다 업데이트하고 싶다면 다음처럼 하면 된다.

```javascript
moment.relativeTimeThreshold('ss', 0);

// 예를 들어 모든 <span class="moment" title="(절대 시간)"></span> 에 대해
// 절대 시간을 상대 시간로 바꿔서 span 안에 표기한다면
document.querySelectorAll('.moment').forEach((e) => {
  e.innerHTML = moment(e.title).fromNow();
});

// 인터벌을 걸어주면 업데이트도 가능
setInterval(() => {
  document.querySelectorAll('.moment').forEach((e) => {
    e.innerHTML = moment(e.title).fromNow();
  });
}, 1000);
```

즉, 상대 시간의 threshold 값을 `0`으로 만들어서 처리한 후 인터벌을 걸면 된다.

`moment.js`의 threshold 관련 내용은 여기를 참고.

- https://momentjs.com/docs/#/customization/relative-time-threshold/

참고로 `moment.js`는 이제 업데이트가 되지 않으니 `day.js` 등 다른 라이브러리를 쓰는 게 좋겠다.
