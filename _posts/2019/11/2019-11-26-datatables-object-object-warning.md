---
layout: post
title: DataTables에서 [object object] warning을 띄울 때
date: 2019-11-26 11:50:00 +0900
tags:
- datatables
- warning
- error
---
[DataTables](https://datatables.net/)에는 [ajax](https://datatables.net/reference/option/ajax) 옵션이 있어서 데이터를 json 형태로 외부로부터 받아올 수 있다.

그런데, 데이터도 멀쩡하고, 연결된 컬럼 설정도 멀쩡한데도 이런 에러가 튀어나올 때가 있다.

```
DataTables warning: table id=token-table - [object Object]
```

DataTables의 ajax 옵션 코드를 보면 json 데이터에 `error` 혹은 `sError` 엘리먼트가 있으면 에러 로그를 보여주게 되어 있다.

```javascript
// jquery.dataTables.js 중에서
var baseAjax = {
  "data": data,
  "success": function (json) {
    var error = json.error || json.sError;
    if ( error ) {
      _fnLog( oSettings, 0, error );
    }
    ...
```

예를 들면 데이터가 아래와 같다면,

```json
{
  "error": {
    "code": 200,
    "text": "No problem. It's Okay"
  },
  "data": [
    "user1",
    "user2",
    "user3",
    "user4"
  ]
}
```

`error`를 감지해 경고를 띄울텐데, `error`안에 또 다른 엘리먼트들이 존재하니 `[object object]`를 띄우는 것.

저 에러를 안 뜨게 하려면 당연히 DataTables 코드를 직접 고치면 될테고, 아래처럼 DataTables를 쓰기 전에 그냥 에러 메시지를 뱉지 않도록 코드를 추가해도 된다.

```javascript
$.fn.dataTable.ext.errMode = 'none';

$('#tableId').DataTable({
  ajax: {
    url: 'https://www.example.com/api/users',
    type: 'GET',
    ...
```