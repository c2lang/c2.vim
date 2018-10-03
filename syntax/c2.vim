" Vim syntax file
" Language: C2
" Maintainer: Bas van den Berg
" Latest Revision: 03 October 2018

if exists("b:current_syntax")
  finish
endif

let b:current_syntax = "c2"

syn case match

" Modules
syn keyword     c2Directive         module import as c2

hi def link     c2Directive         Statement

" keyword local is special: in imports, treat it as keyword, otherwise as type
syn match       c2Type              /^\s*local\>/
syn match       c2Directive         /\<local\>/

syn keyword     c2DeclType          func struct type enum union const public
syn keyword     c2Type              bool f32 f64 i8 i16 i32 i64 u8 u16 u32 u64 char void
syn keyword     c2Type              c_char c_int c_uint c_long c_longlong c_ulong c_ulonglong c_size c_ssize c_float c_double
syn keyword     c2Constant          nil
syn keyword     c2Constant          buildtime
syn keyword     c2Constant          min_i8 max_i8 min_u8 max_u8 min_i16 max_i16 min_u16 max_u16
syn keyword     c2Constant          min_i32 max_i32 min_u32 max_u32 min_i64 max_i64 min_u64 max_u64
syn keyword     c2Boolean           true false

hi def link     c2DeclType          Structure
hi def link     c2Type              Type
hi def link     c2Constant          Constant
hi def link     c2Boolean           Boolean

syn keyword     c2Storage           volatile
syn keyword     c2Statement         break return continue asm goto fallthrough
syn keyword     c2Conditional       if else switch
syn keyword     c2Label             case default
syn keyword     c2Repeat            while for do

hi def link     c2Storage           StorageClass
hi def link     c2Statement         Statement
hi def link     c2Conditional       Conditional
hi def link     c2Label             Label
hi def link     c2Repeat            Repeat

syn keyword     c2Keyword           sizeof elemsof enum_min enum_max cast

hi def link     c2Keyword           Keyword

" Attributes
"TODO parse @() + known attributes

" Comments
syn keyword     c2Todo              contained TODO FIXME XXX BUG
syn cluster     c2CommentGroup      contains=c2Todo
syn region      c2Comment           start="/\*" end="\*/" contains=@c2CommentGroup,@Spell
syn region      c2Comment           start="//" end="$" contains=@c2CommentGroup,@Spell

hi def link     c2Comment           Comment
hi def link     c2Todo              Todo

" Escapes
syn match       c2EscapeOctal       display contained "\\[0-7]\{3}"
syn match       c2EscapeC           display contained +\\[abfnrtv\\'"]+
syn match       c2EscapeX           display contained "\\x\x\{2}"
syn match       c2EscapeU           display contained "\\u\x\{4}"
syn match       c2EscapeBigU        display contained "\\U\x\{8}"
syn match       c2EscapeError       display contained +\\[^0-7xuUabfnrtv\\'"]+

hi def link     c2EscapeOctal       c2SpecialString
hi def link     c2EscapeC           c2SpecialString
hi def link     c2EscapeX           c2SpecialString
hi def link     c2EscapeU           c2SpecialString
hi def link     c2EscapeBigU        c2SpecialString
hi def link     c2SpecialString     Special
hi def link     c2EscapeError       Error

" Strings and their contents
syn cluster     c2StringGroup       contains=c2EscapeOctal,c2EscapeC,c2EscapeX,c2EscapeU,c2EscapeBigU,c2Es
syn region      c2String            start=+"+ skip=+\\\\\|\\"+ end=+"+ contains=@c2StringGroup
syn region      c2RawString         start=+`+ end=+`+

hi def link     c2String            String
hi def link     c2RawString         String

" Characters; their contents
syn cluster     c2CharacterGroup    contains=c2EscapeOctal,c2EscapeC,c2EscapeX,c2EscapeU,c2EscapeBigU
syn region      c2Character         start=+'+ skip=+\\\\\|\\'+ end=+'+ contains=@c2CharacterGroup

hi def link     c2Character         Character

" Regions
syn region      c2Block             start="{" end="}" transparent fold
syn region      c2Paren             start='(' end=')' transparent

" Integers
syn match       c2DecimalInt        "\<\d\+\([Ee]\d\+\)\?\>"
syn match       c2HexadecimalInt    "\<0x\x\+\>"
syn match       c2OctalInt          "\<0\o\+\>"
syn match       c2OctalError        "\<0\o*[89]\d*\>"

hi def link     c2DecimalInt        Integer
hi def link     c2HexadecimalInt    Integer
hi def link     c2OctalInt          Integer
hi def link     Integer             Number

" Floating point
syn match       c2Float             "\<\d\+\.\d*\([Ee][-+]\d\+\)\?\>"
syn match       c2Float             "\<\.\d\+\([Ee][-+]\d\+\)\?\>"
syn match       c2Float             "\<\d\+[Ee][-+]\d\+\>"

hi def link     c2Float             Float

" Trailing white space error
syn match       c2SpaceError        display excludenl "\s\+$"
hi def link     c2SpaceError        Error

" Pre-processor directives
syn cluster     c2PreProcGroup      contains=cPreCondit,cIncluded,cInclude,c2Define,cErrInParen,cErrInBracket,cUserLabel,cSpecial,cOctalZero,cCppOutWrapper,cCppInWrapper,@cCppOutInGroup,cFormat,cNumber,cFloat,cOctal,cOctalError,cNumbersCom,cString,cCommentSkip,cCommentString,cComment2String,@cCommentGroup,cCommentStartError,cParen,cBracket,cMulti,cBadBlock
syn region      c2Define            start="^\s*\zs\(%:\|#\)\s*\(define\|undef\)\>" skip="\\$" end="$" keepend contains=ALLBUT,@c2PreProcGroup,@Spell
syn region      c2PreProc           start="^\s*\zs\(%:\|#\)\s*\(pragma\>\|line\>\|warning\>\|warn\>\|error\>\)" skip="\\$" end="$" keepend contains=ALLBUT,@c2PreProcGroup,@Spell

hi def link     c2Define            Macro
hi def link     c2PreProc           PreProc

"TODO #if 0 regions
