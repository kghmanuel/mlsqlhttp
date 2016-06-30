(: 
 : Tests for Default / json
 : Uses xdmp:to-json, so test conversion is already covered by ML itself 
 :)

import module namespace test = "http://marklogic.com/roxy/test-helper" at "/test/test-helper.xqy";
import module namespace transform = "http://marklogic.com/sql/result/transform" at "/transform.xqy";

let $input := map:new((
    map:entry("string", "stringvalue")
    , map:entry("integer", 1)
    , map:entry("decimal", 1.2)
    , map:entry("date", xs:date("2010-01-01"))
    , map:entry("time", xs:time("12:59:59"))
  ))
let $result := transform:convert-map($input, ())
let $expected := xdmp:unquote('{"string":"stringvalue", "integer":1, "decimal":1.2, "date":"2010-01-01", "time":"12:59:59"}',"json")
return (
    test:assert-equal($expected/string, $result[1]/string)
  )
;

(: Tests for XML :)
import module namespace test = "http://marklogic.com/roxy/test-helper" at "/test/test-helper.xqy";
import module namespace transform = "http://marklogic.com/sql/result/transform" at "/transform.xqy";

let $input := map:new((
    map:entry("string", "stringvalue")
    , map:entry("integer", 1)
    , map:entry("decimal", 1.2)
    , map:entry("date", xs:date("2010-01-01"))
    , map:entry("time", xs:time("12:59:59"))
  ))
let $result := transform:convert-map($input, "xml")
let $expected := document {<records><record><string>stringvalue</string><integer>1</integer><decimal>1.2</decimal><date>2010-01-01</date><time>12:59:59</time></record></records>}
return (
  test:assert-equal(
    count($expected/records/record)
    , count($result/records/record))
  , test:assert-equal(
    $expected/records/record[1]/string
    , $result/records/record[1]/string)
  )
;

(: Tests for CSV :)
import module namespace test = "http://marklogic.com/roxy/test-helper" at "/test/test-helper.xqy";
import module namespace transform = "http://marklogic.com/sql/result/transform" at "/transform.xqy";

let $input := map:new((
    map:entry("string", "stringvalue")
    , map:entry("integer", 1)
    , map:entry("decimal", 1.2)
    , map:entry("date", xs:date("2010-01-01"))
    , map:entry("time", xs:time("12:59:59"))
  ))
let $result := transform:convert-map($input, "csv")
let $parts := tokenize($result, "
") 
let $expectedHeader := ("string","integer","decimal","date","time")
let $expectedValue := ("stringvalue","1","1.2","2010-01-01","12:59:59")
return (
  test:assert-same-values(
    $expectedHeader
    , tokenize($parts[1], ","))
  , test:assert-same-values(
    $expectedValue
    , tokenize($parts[2], ","))
  )
;

(: TODO: Add more tests :)