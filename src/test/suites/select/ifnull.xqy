(: 
 : Tests for basic retrieval 
 :)

import module namespace test = "http://marklogic.com/roxy/test-helper" at "/test/test-helper.xqy";
import module namespace select = "http://marklogic.com/sql/select" at "/select.xqy";
import module namespace parser = "http://marklogic.com/test/select/parser-helper" at "../parser-helper.xqy";

let $sql := "select ifnull(age, 0), ifnull(unknownfield, 'unknown') as unknown 
 from person"
let $stmt := parser:execute($sql)
let $result := select:execute($stmt)
for $item in $result
return (
    (:
     : There is an issue with the parser where the generated alias
     : does not include the ', <value>' part of the function.
     :
     : It is therefore best to have them use an alias 
     :)
    test:assert-true(not(empty(map:get($item, "ifnull(age)"))))
    , test:assert-true(not(empty(map:get($item, "unknown"))))
  )
;

import module namespace test = "http://marklogic.com/roxy/test-helper" at "/test/test-helper.xqy";
import module namespace select = "http://marklogic.com/sql/select" at "/select.xqy";
import module namespace parser = "http://marklogic.com/test/select/parser-helper" at "../parser-helper.xqy";

let $sql := "select distinct ifnull(age, 0), count(1) 
 from person"
let $stmt := parser:execute($sql)
let $result := select:execute($stmt)
for $item in $result
return (
    (:
     : There is an issue with the parser where the generated alias
     : does not include the ', <value>' part of the function.
     :
     : Another issue in the parser is the "count" when using a literal as input.
     :
     : It is therefore best to have them use an alias 
     :)
    test:assert-true(not(empty(map:get($item, "ifnull(age)"))))
    , test:assert-true(not(empty(map:get($item, "count(undefined)"))))
  )
;

import module namespace test = "http://marklogic.com/roxy/test-helper" at "/test/test-helper.xqy";
import module namespace select = "http://marklogic.com/sql/select" at "/select.xqy";
import module namespace parser = "http://marklogic.com/test/select/parser-helper" at "../parser-helper.xqy";

let $sql := "select ifnull(age, 0) as age, ifnull(unknownfield, 'unknown') as unknown, count(1) 
 from person
 group by age"
let $stmt := parser:execute($sql)
let $result := select:execute($stmt)
for $item in $result
return (
    (:
     : There is an issue with the parser where the generated alias
     : does not include the ', <value>' part of the function.
     :
     : Another issue in the parser is the "count" when using a literal as input.
     :
     : It is therefore best to have them use an alias 
     :)
    test:assert-true(not(empty(map:get($item, "age"))))
    , test:assert-true(not(empty(map:get($item, "unknown"))))
    , test:assert-true(not(empty(map:get($item, "count(undefined)"))))
  )
;
