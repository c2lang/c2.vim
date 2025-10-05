" Vim syntax file
" Language: C2
" Maintainer: Bas van den Berg
" Latest Revision: 03 October 2018

if exists("b:current_syntax")
  finish
endif

let b:current_syntax = "c2"

syn case match

syn match PreProc        '[@]'
syn match ocenSymbol     '[,;]'
syn match Operator       '[\+\-\%=\/\^\&\*!?><\$|]'
syn match SpecialComment '[`:\.]'
syn match Constant       '[{}\[\]()]'

"syn match Operator    '[\+\-\%=\^\&\*!?><\$|:/]'
syn match Repeat      "\([^\.]\.\)\@<=\w\w*\(\(\[.*\]\)*\_s*(\)\@!"
syn match Function    "[0-9a-zA-Z_@]*\w\w*\(\(\[.*\]\)*\_s*(\)\@="
syn match Exception   "^\w\+\s*\(:$\)\@="

" Modules
syn keyword     c2Directive         module import public

hi def link     c2Directive         Include

" keyword local is special: in imports; treat it as keyword, otherwise as type
syn match       c2Type              /^\s*local\>/
syn match       c2Directive         /\<local\>/

syn keyword     Label export packed unused unused_params section noreturn printf_format inline aligned weak opaque cname no_typedef constructor destructor auto_file auto_line
syn keyword     Structure           struct enum union template
syn keyword     c2DeclType          fn type const
syn keyword     c2Type              bool f32 f64 i8 i16 i32 i64 isize u8 u16 u32 u64 usize char void reg8 reg16 reg32 reg64
syn keyword     c2Type              c_char c_uchar c_int c_uint c_long c_longlong c_ulong c_ulonglong c_size c_ssize c_float c_double
syn keyword     c2Type              int8_t uint8_t int16_t uint16_t int32_t uint32_t int64_t uint64_t size_t ssize_t float double
syn keyword     c2Constant          nil
syn keyword     c2Constant          buildtime
syn keyword     c2Constant          min_i8 max_i8 min_u8 max_u8 min_i16 max_i16 min_u16 max_u16
syn keyword     c2Constant          min_i32 max_i32 min_u32 max_u32 min_i64 max_i64 min_u64 max_u64
syn keyword     c2Constant          min_isize max_isize min_usize max_usize
syn keyword     c2Boolean           true false

hi def link     c2DeclType          Keyword
"hi def link     c2Type              Statement
hi def link     c2Constant          Constant
hi def link     c2Boolean           Statement
hi def c2Type   ctermfg=DarkCyan guifg=DarkCyan

syn keyword     c2Storage           volatile
syn keyword     c2Statement         break return continue asm goto fallthrough
syn keyword     c2Conditional       if else switch
syn keyword     c2Label             case default
syn keyword     c2Repeat            while for do
syn keyword     Operator            as c2

hi def link     c2Storage           Statement
hi def link     c2Statement         Statement
hi def link     c2Conditional       Conditional
hi def link     c2Label             Label
hi def link     c2Repeat            Repeat

syn keyword     c2Keyword           sizeof offsetof elemsof enum_min enum_max cast to_container assert static_assert static

hi def link     c2Keyword           Keyword

" Attributes
syn keyword     c2Attribute         contained export packed unused unused_params section noreturn inline aligned weak constructor destructor opaque printf_format auto_file auto_line pure
"syn cluster     c2AttrGroup         contains=c2Attribute
"syn region      c2Attribute        start="@(" end=")" contains=@c2AttrGroup, c2String, c2DecimalInt, c2HexadecimalInt, c2OctalInt, c2Character
hi def link     c2Attribute        Keyword

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
syn cluster     c2StringGroup       contains=c2EscapeOctal,c2EscapeC,c2EscapeX,c2EscapeU,c2EscapeBigU,c2EscapeError
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
syn cluster     c2PreProcGroup      contains=cPreCondit,cIncluded,cInclude,c2Define,cErrInParen,cErrInBracket,cUserLabel,cSpecial,cOctalZero,cCppOutWrapper,cCppInWrapper,@cCppOutInGroup,cFormat,cNumber,cFloat,cOctal,cOctalError,cNumbersCom,cString,cCommentSkip,cCommentString,cComment2String,@cCommentGroup,cCommentStartError,cParen,cBracket,cMulti,cBadBlock,c2Comment
syn region      c2Define            start="^\s*\zs\(%:\|#\)\s*\(define\|undef\)\>" skip="\\$" end="$" keepend contains=ALLBUT,@c2PreProcGroup,@Spell
syn region      c2PreProc           start="^\s*\zs\(%:\|#\)\s*\(pragma\>\|line\>\|warning\>\|warn\>\|error\>\)" skip="\\$" end="$" keepend contains=ALLBUT,@c2PreProcGroup,@Spell

hi def link     c2Define            Macro
hi def link     c2PreProc           PreProc

" Comment out #if 0 regions
syn region      cPreCondit          start="^\s*\zs\(%:\|#\)\s*\(if\|ifdef\|ifndef\|elif\)\>" skip="\\$" end="$" keepend contains=c2Comment,c2CommentL,cCppString,cCharacter,cCppParen,cParenError,cNumbers,cCommentError,cSpaceError
syn match       cPreConditMatch     display "^\s*\zs\(%:\|#\)\s*\(else\|endif\)\>"
if !exists("c_no_if0")
  syn cluster   cCppOutInGroup  contains=cCppInIf,cCppInElse,cCppInElse2,cCppOutIf,cCppOutIf2,cCppOutElse,cCppInSkip,cCppOutSkip
  syn region    cCppOutWrapper  start="^\s*\zs\(%:\|#\)\s*if\s\+0\+\s*\($\|//\|/\*\|&\)" end=".\@=\|$" contains=cCppOutIf,cCppOutElse,@NoSpell fold
  syn region    cCppOutIf       contained start="0\+" matchgroup=cCppOutWrapper end="^\s*\(%:\|#\)\s*endif\>" contains=cCppOutIf2,cCppOutElse
  if !exists("c_no_if0_fold")
    syn region  cCppOutIf2      contained matchgroup=cCppOutWrapper start="0\+" end="^\s*\(%:\|#\)\s*\(else\>\|elif\s\+\(0\+\s*\($\|//\|/\*\|&\)\)\@!\|endif\>\)"me=s-1 contains=cSpaceError,cCppOutSkip,@Spell fold
  else
    syn region  cCppOutIf2      contained matchgroup=cCppOutWrapper start="0\+" end="^\s*\(%:\|#\)\s*\(else\>\|elif\s\+\(0\+\s*\($\|//\|/\*\|&\)\)\@!\|endif\>\)"me=s-1 contains=cSpaceError,cCppOutSkip,@Spell
  endif
  syn region    cCppOutElse     contained matchgroup=cCppOutWrapper start="^\s*\(%:\|#\)\s*\(else\|elif\)" end="^\s*\(%:\|#\)\s*endif\>"me=s-1 contains=TOP,cPreCondit
  syn region    cCppInWrapper   start="^\s*\zs\(%:\|#\)\s*if\s\+0*[1-9]\d*\s*\($\|//\|/\*\||\)" end=".\@=\|$" contains=cCppInIf,cCppInElse fold
  syn region    cCppInIf        contained matchgroup=cCppInWrapper start="\d\+" end="^\s*\(%:\|#\)\s*endif\>" contains=TOP,cPreCondit
  if !exists("c_no_if0_fold")
    syn region  cCppInElse      contained start="^\s*\(%:\|#\)\s*\(else\>\|elif\s\+\(0*[1-9]\d*\s*\($\|//\|/\*\||\)\)\@!\)" end=".\@=\|$" containedin=cCppInIf contains=cCppInElse2 fold
  else
    syn region  cCppInElse      contained start="^\s*\(%:\|#\)\s*\(else\>\|elif\s\+\(0*[1-9]\d*\s*\($\|//\|/\*\||\)\)\@!\)" end=".\@=\|$" containedin=cCppInIf contains=cCppInElse2
  endif
  syn region    cCppInElse2     contained matchgroup=cCppInWrapper start="^\s*\(%:\|#\)\s*\(else\|elif\)\([^/]\|/[^/*]\)*" end="^\s*\(%:\|#\)\s*endif\>"me=s-1 contains=cSpaceError,cCppOutSkip,@Spell
  syn region    cCppOutSkip     contained start="^\s*\(%:\|#\)\s*\(if\>\|ifdef\>\|ifndef\>\)" skip="\\$" end="^\s*\(%:\|#\)\s*endif\>" contains=cSpaceError,cCppOutSkip
  syn region    cCppInSkip      contained matchgroup=cCppInWrapper start="^\s*\(%:\|#\)\s*\(if\s\+\(\d\+\s*\($\|//\|/\*\||\|&\)\)\@!\|ifdef\>\|ifndef\>\)" skip="\\$" end="^\s*\(%:\|#\)\s*endif\>" containedin=cCppOutElse,cCppInIf,cCppInSkip contains=TOP,cPreProc
endif

syn region      cCppSkip            contained start="^\s*\(%:\|#\)\s*\(if\>\|ifdef\>\|ifndef\>\)" skip="\\$" end="^\s*\(%:\|#\)\s*endif\>" contains=cSpaceError,cCppSkip
syn cluster     cStringGroup        contains=cCppString,cCppSkip
hi def link     cPreCondit          PreCondit
hi def link     cPreConditMatch     cPreCondit
hi def link     cCppInWrapper       cCppOutWrapper
hi def link     cCppOutWrapper      cPreCondit
hi def link     cCommentString      cString
hi def link     cComment2String     cString
hi def link     cCommentSkip        cComment
hi def link     cComment            Comment
hi def link     cCppOutSkip         cCppOutIf2
hi def link     cCppInElse2         cCppOutIf2
hi def link     cCppOutIf2          cCppOut
hi def link     cCppOut             Comment

compiler c2c
