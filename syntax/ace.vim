" Vim syntax file
" Language: Ace
" Maintainer: Keiji Yoshida <yoshida.keiji.84@gmail.com>
" Version:  1
" Last Change:  2014 July 26

" Quit when a syntax file is already loaded.
if exists("b:current_syntax")
  finish
endif

if !exists("main_syntax")
  let main_syntax = 'ace'
endif

" Allows a per line syntax evaluation.
let b:ruby_no_expensive = 1

" Include Ruby syntax highlighting
syn include @aceRubyTop syntax/ruby.vim
unlet! b:current_syntax
" Include Haml syntax highlighting
syn include @aceHaml syntax/haml.vim
unlet! b:current_syntax

syn match aceBegin  "^\s*\(&[^= ]\)\@!" nextgroup=aceTag,aceClassChar,aceIdChar,aceRuby

syn region  rubyCurlyBlock start="{" end="}" contains=@aceRubyTop contained
syn cluster aceRubyTop    add=rubyCurlyBlock

syn cluster aceComponent contains=aceClassChar,aceIdChar,aceWrappedAttrs,aceRuby,aceAttr,aceInlineTagChar

syn keyword aceDocType        contained html 5 1.1 strict frameset mobile basic transitional
syn match   aceDocTypeKeyword "^\s*\(doctype\)\s\+" nextgroup=aceDocType

syn keyword aceTodo        FIXME TODO NOTE OPTIMIZE XXX contained

syn match aceTag           "\w\+"         contained contains=htmlTagName nextgroup=@aceComponent
syn match aceIdChar        "#{\@!"        contained nextgroup=aceId
syn match aceId            "\%(\w\|-\)\+" contained nextgroup=@aceComponent
syn match aceClassChar     "\."           contained nextgroup=aceClass
syn match aceClass         "\%(\w\|-\)\+" contained nextgroup=@aceComponent
syn match aceInlineTagChar "\s*:\s*"      contained nextgroup=aceTag,aceClassChar,aceIdChar

syn region aceWrappedAttrs matchgroup=aceWrappedAttrsDelimiter start="\s*{\s*" skip="}\s*\""  end="\s*}\s*"  contained contains=aceAttr nextgroup=aceRuby
syn region aceWrappedAttrs matchgroup=aceWrappedAttrsDelimiter start="\s*\[\s*" end="\s*\]\s*" contained contains=aceAttr nextgroup=aceRuby
syn region aceWrappedAttrs matchgroup=aceWrappedAttrsDelimiter start="\s*(\s*"  end="\s*)\s*"  contained contains=aceAttr nextgroup=aceRuby

syn match aceAttr "\s*\%(\w\|-\)\+\s*" contained contains=htmlArg nextgroup=aceAttrAssignment
syn match aceAttrAssignment "\s*=\s*" contained nextgroup=aceWrappedAttrValue,aceAttrString

syn region aceWrappedAttrValue matchgroup=aceWrappedAttrValueDelimiter start="{" end="}" contained contains=aceAttrString,@aceRubyTop nextgroup=aceAttr,aceRuby,aceInlineTagChar
syn region aceWrappedAttrValue matchgroup=aceWrappedAttrValueDelimiter start="\[" end="\]" contained contains=aceAttrString,@aceRubyTop nextgroup=aceAttr,aceRuby,aceInlineTagChar
syn region aceWrappedAttrValue matchgroup=aceWrappedAttrValueDelimiter start="(" end=")" contained contains=aceAttrString,@aceRubyTop nextgroup=aceAttr,aceRuby,aceInlineTagChar

syn region aceAttrString start=+\s*"+ skip=+\%(\\\\\)*\\"+ end=+"\s*+ contained contains=aceInterpolation,aceInterpolationEscape nextgroup=aceAttr,aceRuby,aceInlineTagChar
syn region aceAttrString start=+\s*'+ skip=+\%(\\\\\)*\\"+ end=+'\s*+ contained contains=aceInterpolation,aceInterpolationEscape nextgroup=aceAttr,aceRuby,aceInlineTagChar

syn region aceInnerAttrString start=+\s*"+ skip=+\%(\\\\\)*\\"+ end=+"\s*+ contained contains=aceInterpolation,aceInterpolationEscape nextgroup=aceAttr
syn region aceInnerAttrString start=+\s*'+ skip=+\%(\\\\\)*\\"+ end=+'\s*+ contained contains=aceInterpolation,aceInterpolationEscape nextgroup=aceAttr

syn region aceInterpolation matchgroup=aceInterpolationDelimiter start="#{" end="}" contains=@hamlRubyTop containedin=javascriptStringS,javascriptStringD,aceWrappedAttrs
syn match  aceInterpolationEscape "\\\@<!\%(\\\\\)*\\\%(\\\ze#{\|#\ze{\)"

syn region aceRuby matchgroup=aceRubyOutputChar start="\s*[=]\==[']\=" skip=",\s*$" end="$" contained contains=@aceRubyTop keepend
syn region aceRuby matchgroup=aceRubyChar       start="\s*-"           skip=",\s*$" end="$" contained contains=@aceRubyTop keepend

syn match aceComment /^\(\s*\)[/].*\(\n\1\s.*\)*/ contains=aceTodo
syn match aceText    /^\(\s*\)[`|'].*\(\n\1\s.*\)*/

syn match aceFilter /\s*\w\+:\s*/                            contained
syn match aceHaml   /^\(\s*\)\<haml:\>.*\(\n\1\s.*\)*/       contains=@aceHaml,aceFilter

syn match aceIEConditional "\%(^\s*/\)\@<=\[\s*if\>[^]]*]" contained containedin=aceComment

hi def link aceAttrString                String
hi def link aceBegin                     String
hi def link aceClass                     Type
hi def link aceClassChar                 Type
hi def link aceComment                   Comment
hi def link aceDocType                   Identifier
hi def link aceDocTypeKeyword            Keyword
hi def link aceFilter                    Keyword
hi def link aceIEConditional             SpecialComment
hi def link aceId                        Identifier
hi def link aceIdChar                    Identifier
hi def link aceInnerAttrString           String
hi def link aceInterpolationDelimiter    Delimiter
hi def link aceRubyChar                  Special
hi def link aceRubyOutputChar            Special
hi def link aceText                      String
hi def link aceTodo                      Todo
hi def link aceWrappedAttrValueDelimiter Delimiter
hi def link aceWrappedAttrsDelimiter     Delimiter
hi def link aceInlineTagChar             Delimiter

let b:current_syntax = "ace"
