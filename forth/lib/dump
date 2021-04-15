\ dump ( address n )
\ hexadecimal dump

: n1ascii ( x -- x<<4 n0 )
  dup $f and [char] 0 + dup [char] 9 > if #7 + then swap #4 rshift ;
: n2ascii ( x -- x<<8 n0 n1 )
  n1ascii n1ascii ;
: n4ascii ( x -- x<<16 n0 n1 n2 n3 )
  n2ascii n2ascii ;
: n8ascii ( x -- x<<32 n0 n1 n2 n3 n4 n5 n6 n7 )
  n4ascii n4ascii ;

: emit2 emit emit ;
: emit4 emit2 emit2 ;
: emit8 emit4 emit4 ;

: n1. n1ascii drop emit ;
: n2. n2ascii drop emit2 ;
: n4. n4ascii drop emit4 ;
: n8. n8ascii drop emit8 ;


: range? ( n min max -- flag )
  #2 pick < rot rot < or not ;

\ is char a printable ascii?
: ascii? ( char -- flag )
  bl [char] ~ range? ;

\ print char if printable, else print a dot
: emit_if_ascii dup ascii? if else drop [char] . then emit ;


: dumpchars                           ( address n linecounter )
  dup #16 swap - dup 2* + #2 + spaces ( address n linecounter )
  rot over - swap                     ( n address-linecounter linecounter )
  begin
    dup 0<>
  while                               ( n address linecounter )
    swap dup c@ emit_if_ascii 1+ swap \ address increments while
    1-                                \ linecounter decrements to zero
  repeat
  rot swap                            ( address n linecounter )
;

: dump                                ( address n )
  0                                   ( address n linecounter )
  begin
    over 0<>
  while
    swap 1- swap
    dup 0= if                         \ linecounter==0, print CR and address
      cr #2 pick n8. [char] : emit space space then
    rot dup c@ n2. space 1+ rot rot   \ print byte and SPACE, increment address
    1+
    dup #16 = if dumpchars then       \ linecounter==16, print asciis and zero linecounter
  repeat
  dumpchars
  drop drop drop cr
;
