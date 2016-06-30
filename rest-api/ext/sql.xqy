xquery version "1.0-ml";

module namespace ext = "http://marklogic.com/rest-api/resource/sql";
declare default function namespace "http://marklogic.com/rest-api/resource/sql";

import module namespace s = "http://marklogic.com/sql" at "/sql.xqy";

(:
 : curl -X POST --anyauth -umlsqlhttp-user:mlsqlhttp-password "http://localhost:1040/v1/resources/sql?rs:format=json" -H "Content-Type: application/txt" -d "select * from person"
 :)
declare function post(
    $context as map:map,
    $params  as map:map,
    $input   as document-node()*
) as document-node()? {
  s:execute(xdmp:quote($input), $params) 
};
