module namespace helper = "http://marklogic.com/test/select/parser-helper";
declare default function namespace "http://marklogic.com/test/select/parser-helper";

(: This basically does what sql.xqy does. :)
declare function execute($sql as xs:string) as node(){
  let $parsed := xdmp:javascript-eval('
      var sqlp = require("/ext/parser.sjs");
      var sql;
      sqlp.parse(sql);
      ', ('sql', $sql))
  return xdmp:unquote(xdmp:quote($parsed))/statement
};