---
layout: post
title: 기존 작업 중인 디렉토리에 git 리포 연결하기
date: 2022-01-21 11:00:00 +0900
tags:
  - git
  - repository
---

보통 작업할 때 처음부터 git 리포로부터 clone해서 로컬에 내려받아 작업하지만, 가끔은 이미 로컬에서 끄적끄적 하다가 소스를 git에 올려두고 싶을 때도 있다.

리모트 저장소 주소가 변경됐을 때도 같은 방식으로 처리하면 된다.

간략한 프로세스는 아래와 같다.

```sh
# github이나 bitbucket 등에 리포를 생성한다.
# 리포 주소를 https://github.com/sasohan/myapp 이라고 한다면,

# 현재 작업 중인 로컬 디렉토리에서 git을 초기화한다.
git init

# 생성한 리포를 리모트 저장소로 추가한다.
git remote add origin https://github.com/sasohan/myapp

# 일단 리모트의 것을 가져오고, (기본 브랜치는 master일 것이고)
git pull origin master

# 로컬 디렉토리의 모든 소스를 로컬 저장소에 추가한다.
git add .

# commit 하고,
git commit -m 'init'

# 리모트 저장소에 전송한다.
git push -u origin master
```

참고로, 만약 여러 git 서비스의 여러 계정을 이용하고 있다면 commit, push 하기 전에 현재 자신의 계정 상태를 파악하는 것이 좋다.

```sh
# 내 이름, 이메일 확인
git config user.name
git config user.email

# 내 이름, 이메일 수정
git config user.name 홍길동
git config user.email hong@gildong.com
```
