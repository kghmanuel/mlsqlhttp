(: 
 : Tests for basic retrieval 
 :)

import module namespace test = "http://marklogic.com/roxy/test-helper" at "/test/test-helper.xqy";
import module namespace select = "http://marklogic.com/sql/select" at "/select.xqy";
import module namespace parser = "http://marklogic.com/test/select/parser-helper" at "../parser-helper.xqy";

let $sql := 'SeLECT personid, country as cOUnTry  
FROM address 
limit 10'
let $stmt := parser:execute($sql)
let $result := select:execute($stmt)
let $expected := (
  "personid", "cOUnTry", "document-uri"
  )
return (
    test:assert-same-values($expected, map:keys($result[1]))
  )
;
