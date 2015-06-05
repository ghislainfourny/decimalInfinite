jsoniq version "1.0";
module namespace decimals = "http://28.io/modules/decimals";

declare function decimals:sign($d as decimal) as integer
{
    switch(true)
    case $d eq 0 return 0
    case $d lt 0 return -1
    case $d gt 0 return 1
    default return error()
};

declare function decimals:exponent-sign($d as decimal) as integer
{
    let $d := $d * decimals:sign($d)
    return
        switch(true)
        case $d eq 1 return 0
        case $d lt 1 return -1
        case $d gt 1 return 1
        default return error()
};

declare function decimals:exponent($d as decimal) as integer
{
    let $d := $d * decimals:sign($d)
    return if($d eq 0) then 0 else decimals:exponent-rec($d)
};

declare %private function decimals:exponent-rec($d as decimal) as integer
{
    switch(true)
    case $d eq 0 return 0
    case $d ge 1 and $d lt 10 return 0
    case $d ge 10 return 1 + decimals:exponent-rec($d div 10)
    case $d lt 1 return 1 + decimals:exponent-rec($d * 10)
    default return error()
};

declare function decimals:significand($d as decimal) as decimal
{
    let $d := $d * decimals:sign($d)
    return if($d eq 0) then 0 else decimals:significand-rec($d)
};

declare %private function decimals:significand-rec($d as decimal) as decimal
{
    switch(true)
    case $d ge 1 and $d lt 10 return $d
    case $d ge 10 return decimals:significand-rec($d div 10)
    case $d lt 1 return decimals:significand-rec($d * 10)
    default return error()
};

declare function decimals:significand-groups($d as decimal) as integer*
{
    let $s := decimals:significand($d)
    let $tetrade := integer(floor($s))
    return ($tetrade, decimals:significand-groups-rec(1000*($s - $tetrade)))
};

declare function decimals:significand-groups-rec($d as decimal) as integer*
{
    let $declet := integer(floor($d))
    let $next := 1000*($d - $declet)
    return ($declet, if($next eq 0) then () else decimals:significand-groups-rec($next))
};

declare function decimals:encode($d as decimal) as string*
{
    let $sign := decimals:sign($d)
    let $e-sign := decimals:encode-sign($sign)
    let $exponent := decimals:exponent($d)
    let $exponent-sign := decimals:exponent-sign($d)
    let $significand := decimals:significand($d)
    let $e-exponent := decimals:encode-exponent($exponent, $sign, $exponent-sign)
    let $e-significand := decimals:encode-significand($significand, $sign)
    return if($sign eq 0) then string-join($e-sign) else string-join(($e-sign, $e-exponent, $e-significand))
};

declare function decimals:encode-sign($s as integer) as string*
{
  switch($s)
  case -1 return ("0", "0")
  case 1 return ("1",  "0")
  case 0 return ("1", "0")
  default return error()
};

declare function decimals:encode-exponent($e as integer, $s as integer, $t as integer) as string*
{
  let $binary := decimals:binary($e + 2)
  let $gamma := ((1 to count($binary) - 1) ! "1", "0", tail($binary))
  return switch(true)
         case $s eq -1 and $t = (0, 1) return decimals:negate($gamma)
         case $s eq -1 and $t eq -1 return $gamma
         case $s eq 1 and $t eq -1 return decimals:negate($gamma)
         case $s eq 1 and $t = (0, 1) return $gamma
         default return error()
};

declare function decimals:negate($bits as string*) as string*
{
    for $b in $bits
    return if($b eq "0") then "1" else "0"
};

declare function decimals:binary($i as integer) as string*
{
  let $next := integer(floor($i div 2))
  return (if($next eq 0) then () else decimals:binary($next), string($i mod 2))  
};

declare function decimals:encode-significand($significand as decimal, $sign as integer)
{
    let $groups :=
      if($sign eq 1)
      then decimals:significand-groups($significand)
      else decimals:significand-groups(10 - $significand)
    let $tetrade :=
      for $h in head($groups)
      let $binary := decimals:binary($h)
      return ((4 - count($binary) ) ! "0", $binary)
    let $declets :=
      for $h in tail($groups)
      let $binary := decimals:binary($h)
      return ((10 - count($binary) ) ! "0", $binary)
    return ($tetrade, $declets)
};
