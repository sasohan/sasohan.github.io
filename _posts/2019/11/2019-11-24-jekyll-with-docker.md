---
layout: post
title: Jekyll을 Docker로 실행
date: 2019-11-24 16:50:00 +0900
tags:
- jekyll
- docker
---

결론부터 말하자면 Jekyll 테마가 설치된 블로그 폴더 안에서 다음의 명령어로 Docker에서 Jekyll을 띄울 수 있다.

```sh
docker run --name myblog --volume="$PWD:/srv/jekyll" -p 4000:4000 -it jekyll/jekyll jekyll serve
```

이후부터는 잡담.

Github에서 Jekyll로 블로그를 만들어 글을 쓴다면, 크게 3가지 운영 방식이 있을 것 같다.

1. 그냥 Github에서 바로 [md 파일을 추가](https://help.github.com/en/github/managing-files-in-a-repository/creating-new-files)해서 포스팅.
2. 일단 로컬에 [Ruby와 Jekyll을 설치](https://jekyllrb-ko.github.io/docs/installation/)한 후 - md 파일 추가, `:4000`에서 프리뷰를 한 후 Github에 푸시.
3. 로컬에 Docker를 설치한 후 - md 파일 추가, `:4000`에서 프리뷰 후 Github에 푸시.

1번은 프리뷰를 바로 못하니 좀 답답하다고 생각할 수 있지만, Github에서 파일 추가하기 전에 그냥 md 파일을 로컬에서 얼마든지 확인할 수 있기 때문에 생각보다 크게 불편하지는 않다.

2번은 Jekyll을 써보자고 생각하면, 가장 일반적인 방법일 듯.

3번은 Docker를 알고 쓰는 사람이라면 로컬에 이것저것 설치하지 않아도 되니 나름 가장 유용한 방법이라 할 수 있다. 게다가 루비로 개발할 예정이 없다면 더더욱 깔끔하다.

<del>(그런데 나는 왜 Ruby, Jekyll, rbenv 등등 별의별 것들을 다 깔았는가...)</del>
