import module namespace test = "http://marklogic.com/roxy/test-helper" at "/test/test-helper.xqy";
import module namespace select = "http://marklogic.com/sql/select" at "/select.xqy";
import module namespace parser = "http://marklogic.com/test/select/parser-helper" at "../parser-helper.xqy";

let $sql := "SeLECT * 
FROM person 
order by id 
limit 1 
offset 3
"
let $stmt := parser:execute($sql)
let $result := select:execute($stmt)
return (
    test:assert-equal(1, count($result))
    , test:assert-equal("3", map:get($result[1], "id"))
  )
;

import module namespace test = "http://marklogic.com/roxy/test-helper" at "/test/test-helper.xqy";
import module namespace select = "http://marklogic.com/sql/select" at "/select.xqy";
import module namespace parser = "http://marklogic.com/test/select/parser-helper" at "../parser-helper.xqy";

let $sql := "SeLECT * 
FROM person 
order by id 
limit 3, 1 
"
let $stmt := parser:execute($sql)
let $result := select:execute($stmt)
return (
    test:assert-equal(1, count($result))
    , test:assert-equal("3", map:get($result[1], "id"))
  )
;
