---
layout: post
title: Jekyll 포스트에서 timezone 문제
date: 2019-11-24 14:29:11 +0900
tags:
- jekyll
- timezone
---

포스트 파일을 추가해도 블로그에 나오지 않으면 포스트의 date 항목의 날짜값 뒤에 표준시를 적어주면 된다.

한국을 예로 들면 UTC+09:00 이므로 +0900을 붙이면 된다.

```markdown
---
layout: post
title: 포스팅 제목 제목
date: 2019-11-24 14:29:11 +0900
---
```
