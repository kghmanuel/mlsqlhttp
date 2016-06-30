(: 
 : Tests for basic retrieval 
 :)

import module namespace test = "http://marklogic.com/roxy/test-helper" at "/test/test-helper.xqy";
import module namespace select = "http://marklogic.com/sql/select" at "/select.xqy";
import module namespace parser = "http://marklogic.com/test/select/parser-helper" at "../parser-helper.xqy";

let $sql := "SeLECT * 
FROM address 
where country like '%hili%' "
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
    test:assert-equal("Philippines", map:get($item, "country"))
  )
;
