import module namespace decimals = "http://28.io/modules/decimals";

{|
    (-10 to 10) ! { $$ : decimals:sign($$) }
|}