(: 
 : Tests for basic retrieval 
 :)

import module namespace test = "http://marklogic.com/roxy/test-helper" at "/test/test-helper.xqy";
import module namespace select = "http://marklogic.com/sql/select" at "/select.xqy";
import module namespace parser = "http://marklogic.com/test/select/parser-helper" at "../parser-helper.xqy";

let $sql := 'select max(age), avg(age), min(age) 
from person'
let $stmt := parser:execute($sql)
let $result := select:execute($stmt)
let $expected := (
  map:new((map:entry("max(age)", 23), map:entry("avg(age)", 19.6666666666667), map:entry("min(age)", 18)))
  )
return (
    test:assert-equal(count($expected), count($result))
    (: 
     : As to why i need to do map:new on result is possibly an ML bug.
     : especially when doing xdmp:describe on both results in map:map
     :
     : Also, there is no direct way to actually compare two maps at the moment. 
     :)
    , test:assert-true(map:count($expected[1] - map:new($result[1])) = 0)
  )
;
