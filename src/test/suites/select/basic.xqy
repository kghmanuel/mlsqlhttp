(: 
 : Tests for basic retrieval 
 :)

import module namespace test = "http://marklogic.com/roxy/test-helper" at "/test/test-helper.xqy";
import module namespace select = "http://marklogic.com/sql/select" at "/select.xqy";
import module namespace parser = "http://marklogic.com/test/select/parser-helper" at "../parser-helper.xqy";

let $sql := 'SeLECT *
 FROM person'
let $stmt := parser:execute($sql)
(: This will result in a map* :)
let $result := select:execute($stmt)
let $expected := (
  (: note that the uri in the result is actually xs:anyURI type :)
  map:new((map:entry("document-uri", "/person/1.xml"), map:entry("gender", "M"), map:entry("middle", "Manuel"), map:entry("last", "dela Cruz"), map:entry("first", "Juan"), map:entry("age", "23"), map:entry("id", "1")))
  , map:new((map:entry("document-uri", "/person/3.xml"), map:entry("gender", "F"), map:entry("middle", "E"), map:entry("last", "Doe"), map:entry("first", "Jane"), map:entry("age", "18"), map:entry("id", "3")))
  , map:new((map:entry("document-uri", "/person/2.xml"), map:entry("gender", "F"), map:entry("middle", "E"), map:entry("last", "Corteza"), map:entry("first", "Juana"), map:entry("age", "18"), map:entry("id", "2")))
  , map:new((map:entry("document-uri", "/person/4.xml"), map:entry("gender", "F"), map:entry("middle", "E"), map:entry("last", "Doeson"), map:entry("first", "Janess"), map:entry("id", "3"))))
return (
    test:assert-equal(count($expected), count($result))
    (: 
     : As to why i need to do map:new on result is possibly an ML bug.
     : especially when doing xdmp:describe on both results in map:map 
     :)
    , test:assert-true(map:count($expected[1] - map:new($result[1])) = 0)
    , test:assert-true(map:count($expected[2] - map:new($result[2])) = 0)
    , test:assert-true(map:count($expected[3] - map:new($result[3])) = 0)
    , test:assert-true(map:count($expected[4] - map:new($result[4])) = 0)
  )
;
