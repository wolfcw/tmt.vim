" Vim syntax file
" Language:         TMT
" Maintainer:       wolfcw
" Latest Revision:  02 Apr 2014

if exists("b:current_syntax")
  finish
endif

setlocal iskeyword+=@-@,%

syn match tmtNumber '\d\+' contained
syn match tmtDate   '\d\+\.\d\+\.\d\+' contained
"syn match tmtString '.\+' contained
syn match tmtString '.\+' contained contains=tmtDateCmd,tmtNumberCmd,tmtStringCmd

syn keyword tmtDateCmd A: B: D: E: F: H: M: S: nextgroup=tmtDate skipwhite
syn keyword tmtNumberCmd O: \%: P: nextgroup=tmtNumber skipwhite
syn keyword tmtStringCmd C: I: K: N: R: T: \@: nextgroup=tmtString skipwhite

syn keyword tmtTodo contained TODO FIXME XXX NOTE
syn match tmtComment "//.*$" contains=tmtTodo

syn match tmtTask contained ' \w.\+$'
"syn match tmtTask '.*$' contained
syn match tmtTaskSign '^\s*[\+\-\*\#] .*$' contains=tmtTask

hi def link tmtTodo        Todo
hi def link tmtComment     Comment
hi def link tmtDateCmd     Statement
hi def link tmtNumberCmd   Statement
hi def link tmtStringCmd   Statement
hi def link tmtNumber      LineNr
hi def link tmtDate        LineNr
hi def link tmtString      Question
hi def link tmtTaskSign    Constant
"hi def link tmtTaskSign    PreProc " better for GUI?
hi def link tmtTask        Identifier
"hi def link tmtTask        Type

let b:current_syntax = "tmt"

" eof
