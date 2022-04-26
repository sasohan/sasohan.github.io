---
layout: post
title: auto_increment 값을 빈틈 없이 재조정(리셋)하고 싶다면
date: 2022-04-27 00:30:00 +0900
tags:
  - mysql
  - reset
  - reorder
  - auto_increment
---

`mysql`에서 `primary_key`에 `auto_increment`를 줘서 키 값을 자동으로 증가하게 할 수 있습니다.

`auto_increment` 값은 이름 그대로 계속 늘어나기만 합니다. 만약 특정 `row`를 삭제해서 값이 비어있어도 그 값을 채울 수는 없습니다.

만약 특정한 이유로 `auto_increment`의 값을 빈틈 없이 다시 조정(리셋)해야 할 때는 다음과 같이 하면 됩니다.

```sql
-- 테이블 이름은 my_table, auto_increment 가 적용된 컬럼은 id라고 할 때
ALTER TABLE `my_table` AUTO_INCREMENT = 1;
SET @COUNT = 0;
UPDATE `my_table` SET `id` = @COUNT:= @COUNT + 1;
```
