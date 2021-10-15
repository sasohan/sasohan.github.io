---
layout: post
title: VS Code에서 font ligatures가 안 먹을 때
date: 2021-10-15 09:55:00 +0900
tags:
- vs code
- font
- ligature
---

ligature란 두 개 이상의 문자가 합쳐져서 하나의 글자 모양이 되는 것을 말한다. 합자, 合字라고도 한다.

폰트 중 ligature를 지원하는 것들이 있는데, VS Code는 이 font ligature를 지원한다.

<img src="/img/font-ligature-example.png" />

방법은 간단한데, Settings에 가서 ligature를 지원하는 폰트를 `Editor: Font Familiy`에 적용하면 된다.

만약 이때, ligature 기능이 작동하지 않으면 VS Code의 세팅값이 저장된 `settings.json` 파일을 열어 다음과 같이 `editor.fontLigatures` 항목을 추가해주면 된다. (당연히 `editor.FontFamily`에는 ligature를 지원하는 폰트가 선언되어야 한다.)

```json
{
  "editor.fontFamily": "'Fira Code', Menlo, monospace",
  "editor.fontLigatures": true,
}
```
