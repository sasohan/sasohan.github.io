---
layout: post
title: brew update와 brew upgrade의 차이
date: 2022-01-25 13:40 +0900
tags:
  - brew
  - update
  - upgrade
---

[홈브루(Homebrew)](https://brew.sh/)는 맥용 패키지 관리자다.

macOS에서 여러 오픈 소스 소프트웨어를 쉽게 관리할 수 있게 해주는데, 쓰다 보면 명령어 중 update와 upgrade가 헷갈릴 때가 있다.

가장 간단하게 설명하면 다음과 같다.

`brew update`
- 홈브루 공식 저장소(Homebrew Github)에서 홈브루 자체와 지원하는 포뮬라(formula) 목록을 최신 버전으로 갱신한다.
- 필요한 경우 마이그레이션도 한다.

`brew upgrade`
- 설치된 캐스크(cask) 중 최신이 아닌 모든 것들을 최신 버전으로 업그레이드한다.
- 설치됐거나 핀을 찍지 않는 포뮬라 중 최신이 아닌 모든 것들을 최신 버전으로 업그레이드한다.
- `brew upgrade xxx` 이라고 하면 명시된 `xxx`만 업그레이드한다.

즉, `brew update`는 홈브루 자체를 최신 버전으로 만들고, `brew upgrade`는 홈브루를 통해 설치한 것들(캐스크, 포뮬라)을 최신 버전으로 만든다.

참고로 캐스크(cask)는 홈브루로 설치할 수 있는 GUI 앱을 뜻하며, 포뮬라(formula)는 홈브루로 설치할 수 있는 패키지(CLI로 작동하는 앱)를 말한다.
