import module namespace decimals = "http://28.io/modules/decimals";

{|
    (1 to 10) ! { $$ : decimals:binary($$) }
|}