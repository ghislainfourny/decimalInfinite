import module namespace decimals = "http://28.io/modules/decimals";

declare variable $d as string* external := "3.141592";

{|
    for $d in $d
    let $d := decimal($d)
    return { $d : decimals:encode($d) }
|}