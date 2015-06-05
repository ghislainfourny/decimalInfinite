import module namespace decimals = "http://28.io/modules/decimals";


let $encoded :=
    for $i in -10000 to 10000
    let $i := $i div 100
    return decimals:encode($i)
    
let $sorted :=
    for $e in $encoded
    order by $e ascending
    return $e
    
return (
    for $i in 1 to count($encoded)
    return if ($encoded[$i] eq $sorted[$i]) then () else $i
)