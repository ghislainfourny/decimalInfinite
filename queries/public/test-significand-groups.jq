import module namespace decimals = "http://28.io/modules/decimals";

{|
    for $i in 0.9
    return { $i : decimals:significand-groups($i) }
|}