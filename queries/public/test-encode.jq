import module namespace decimals = "http://28.io/modules/decimals";


{|
    for $i in -200 to 200
    let $i := $i div 10
    return { $i : decimals:encode($i) }
|}