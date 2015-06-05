import module namespace decimals = "http://28.io/modules/decimals";

{|
    for $i in -15 to 15
    let $i := $i div 10
    return { $i : decimals:exponent-sign($i) }
|}