import module namespace decimals = "http://28.io/modules/decimals";

{|
    for $i in -100 to 100
    let $i := $i div 10
    return { $i : decimals:exponent($i) }
|}