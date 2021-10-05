---
layout: post
title: "PDO 사용할 때 SQLSTATE[HY093]: invalid parameter number 가 발생한다면"
date: 2021-10-05 20:45:00 +0900
tags:
- php
- PDO
- HY093
- error
- named parameter
- ATTR_EMULATE_PREPARES
---

```
Fatal error: Uncaught PDOException: SQLSTATE[HY093]: Invalid parameter number
```

이 에러는 `PDO`의 쿼리에 사용되는 파라미터의 개수가 맞지 않은 경우 발생한다.

그런데 만약 별 에러가 없어보이는데 이런 에러가 발생한다면, `ATTR_EMULATE_PREPARES` 속성값 그리고 `named parameter`의 사용 방식과 관련이 있을 수 있다.

아래처럼 `PDO`의 `ATTR_EMULATE_PREPARES` 값을 `false`로 선언하면 같은 값을 가졌더라도 파라미터 수만큼 `named parameter`의 개수를 선언해줘야 한다. 그렇지 않으면 에러가 난다.

```php
$pdo = new PDO("mysql:host=$host;dbname=$db", $user, $pass);
$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
$pdo->setAttribute(PDO::ATTR_EMULATE_PREPARES, false); // <-- 해당 값을 false로 선언

// :val1 을 한번만 선언하면 에러가 발생함
$stmt = $pdo->prepare('INSERT INTO table (col1, col2, col3) VALUE (:val1, :val1, :val1);');
$stmt->bindValue(':val1', $val1);
$stmt->execute(); // error
```

즉, 이 경우는 아래처럼 수정하면 에러가 발생하지 않는다.

```php
$stmt = $pdo->prepare('INSERT INTO table (col1, col2, col3) VALUE (:val1, :val2, :val3);');
$stmt->bindValue(':val1', $val1);
$stmt->bindValue(':val2', $val1);
$stmt->bindValue(':val3', $val1);
$stmt->execute();
```

참고로 `ATTR_EMULATE_PREPARES`는 `DB`가 `prepared statement`를 지원하지 않을 경우 에뮬레이션을 하도록 하는 속성인데, 이 값을 `true`로 선언하면 쿼리 내부의 변수를 `PDO`가 알아서 `escape + concatenate` 한다.

`ATTR_EMULATE_PREPARES` 속성값이 `false`이면 `DB` 자체의 기능(`native prepared statement`)을 사용하게 된다.
