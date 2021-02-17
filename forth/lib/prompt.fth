\ Copied with minors mods from
\ ../upstream/embello/explore/1608-forth/flib/mecrisp/prompt.fs
\ ../upstream/mecrisp-stellaris-2.5.5/common/prompt.txt

\ Prompt by Glen Worstell
\ copied with minor mods from Mecrisp Stellaris "common/prompt.txt"

\ printing in decimal
: .# base @ swap decimal . base ! ; \ Print in decimal and restores base.

\ printing in hex
: .$ base @ hex swap 0 <# # # # # [char] _ hold # # # # #> type space base ! ;

\ printing in binary
: .% base @ swap binary
     0 <#
     7 0 do # # # # [char] _ hold loop
            # # # #
     #> type space base ! ;


\ If a "word" that calls "init" is loaded first, omit next line.
: init ;
\ Glens prompt
: prompt ( -- )
  begin
    compiletoram? if [char] R else [char] F then emit \ show where compiling.
    base @
    case \ show base.
      #10 of [char] # emit endof
      #16 of [char] $ emit endof
      #2  of [char] % emit endof
      ." B" base @ .# \ show base if not # $ %.
    endcase
    depth .# \ show stack depth.
    ." > "    \ show ">" for prompt. Could show "OK."
    query cr interpret cr
  again
;

: init init ['] prompt hook-quit ! ; \ make new prompt

init quit
