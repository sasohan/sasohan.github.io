---
layout: post
title: 여러 페이지에 하나의 자바스크립트를 쓰는 방법론 - 돔 기반 라우팅
date: 2019-12-13 16:55:00 +0900
tags:
- javascript
- paul-irish
- dom
- routing
---

`gulp`나 `webpack` 등을 이용해 여러 파일로 만들어진 자바스크립트를 하나로 모으는 대신, 처음부터 자바스크립트를 1개만 만들고, 여러 페이지에서 그 자바스크립트 1개만 호출하는 방식으로 관리한다면 어떨까.

[**돔 기반 라우팅(DOM-based Routing)**](https://www.paulirish.com/2009/markup-based-unobtrusive-comprehensive-dom-ready-execution/) 이 적절할 수 있다. 2009년에 작성된 글이지만 이제 여러 곳에서 유사한 방식이 쓰이고 있다.

링크는 영어이니, 내 식대로 간단하게 써보면 아래와 같다.

---

일단 `body` 태그에 콘트롤러와 액션이 정의됐다고 하자.

```html
<body data-controller="forum" data-action="list">
```

그리고 액션이 실행되는 순서가 이렇다고 해보자.

```
- 공통 모듈의 init()
- 해당 콘트롤러의 init()
- 해당 콘트롤러의 action()
- 공통 모듈의 finalize()
```

그럼, 그에 맞게 이런 오브젝트를 작성할 수 있다.

```javascript
MyNS = {
  common: {
    init: function(){
      console.log('in common/init');
    },
    finalize: function(){
      console.log('in common/finalize');
    }
  },
  forum: {
    init: function(){
      console.log('in forum/init');
    },
    list: function(){
      console.log('in forum/list');
    }
  }
}
```

이제 `body`에 선언한 콘트롤러와 액션을 오브젝트로 구현을 했는데, 이걸 자동으로 실행하는 코드가 필요하다.

```javascript
UTIL = {
  fire: function(func,func_name, args){
    var namespace = MyNS;  // indicate your obj literal namespace here

    func_name = (func_name === undefined) ? 'init' : func_name;
    if (func !== '' && namespace[func] && typeof namespace[func][func_name] == 'function'){
      namespace[func][func_name](args);
    }
  }, 

  loadEvents: function(){
    // hit up common first.
    UTIL.fire('common');

    // run controller's action
    let controller = document.body.dataset.controller;
    let action = document.body.dataset.action;

    UTIL.fire(controller); // controller's init()
    UTIL.fire(controller, action); // controller's action()

    // hit up common's finalize.
    UTIL.fire('common','finalize');
  }
};
```

페이지 수에 따라 코드가 엄청나게 길어질 수도 있지만, 찾아가는 방법도 비교적 쉽고, 명확하기 때문에, 크지 않은 프로젝트라면 처음부터 이런 구조로 작성하면 괜찮을 수도 있을 듯.