import module namespace test = "http://marklogic.com/roxy/test-helper" at "/test/test-helper.xqy";

test:load-test-file("address/1.xml", xdmp:database(), "/address/1.xml")
, test:load-test-file("address/2.xml", xdmp:database(), "/address/2.xml")
, test:load-test-file("address/3.xml", xdmp:database(), "/address/3.xml")
, test:load-test-file("person/1.xml", xdmp:database(), "/person/1.xml")
, test:load-test-file("person/2.xml", xdmp:database(), "/person/2.xml")
, test:load-test-file("person/3.xml", xdmp:database(), "/person/3.xml")
, test:load-test-file("person/4.xml", xdmp:database(), "/person/4.xml")
