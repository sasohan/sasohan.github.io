---
layout: post
title: Sass에서 변수를 쓰면 숫자가 아니라면서 에러를 낼 때
date: 2021-10-22 12:15:00 +0900
tags:
- sass
- scss
- css
- interpolation
---

Sass(SCSS)에서 변수나 `calc()` 등을 쓰면 숫자가 아니라면서 에러를 낼 때가 있다.

이럴 때는 보간법(interpolation)을 이용하여 처리하면 된다.

```scss
// 에러가 나는 예
$var1: 0.1rem;
$var2: 0.2rem;
* { padding: calc($var1 + $var2);}

// 에러가 나지 않는 예
$var1: 0.1rem;
$var2: 0.2rem;
* { padding: calc(#{$var1} + #{$var2});}

// 에러가 나는 예
* { font-size: min(calc(100% + 1vw), 1.5rem);}

// 에러가 나지 않는 예
* { font-size: #{min(calc(100% + 1vw), 1.5rem)};}
```

즉, `#{ ... }` 이라고 하면 써주면 된다. 구문을 분명하게 표시하기 위해 `#{' ... '}` 처럼 쿼테이션을 넣어서 사용하기도 한다.
