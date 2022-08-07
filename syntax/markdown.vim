if exists("b:current_syntax")
    finish
endif
let b:current_syntax = "markdown"


" Single title
syn match MdH1 '^#\s.*$' contains=headerHashHidden
syn match MdH2 '^##\s.*$' contains=headerHashHidden
syn match MdH3 '^###\s.*$' contains=headerHashHidden
syn match MdH4 '^####\s.*$' contains=headerHashHidden
syn match MdH5 '^#####\s.*$' contains=headerHashHidden
syn match MdH6 '^######\s.*$' contains=headerHashHidden

syn match headerHashHidden '^#\{1,6\} ' conceal cchar= contained


" Markdown quote >
syn match MdQuoteStart '^\s*> ' skipwhite contains=MdQuoteArrow nextgroup=MdQuote
syn match MdQuoteArrow ">" containedin=startQuote contained conceal cchar=│
syn match MdQuote '.*' contained contains=MdPre,MdLinkRef,MdWikilink


" Lists
syn match MdDotStart '^\s*\(\*\|-\|+\) ' skipwhite contains=MdDot nextgroup=MdList

syn match MdDot '\(\*\|-\|+\)' containedin=MdDotStart contained conceal cchar=•


syn match MdList '.*' contained contains=MdPre,MdWikilink

" Numbered lists
syn match MdNumberedListStart '^\s*\d\+\.' skipwhite contains=MdNumberedListHeader nextgroup=MdList
syn match MdNumberedListHeader '\d\+\.' contained

" Links
syn match MdWikilink '\[\[.*\]\]' contains=MdLinkRef,MdLinkBodyContent keepend
syn match MdBeginWikilink '\[\[' conceal cchar= containedin=MdWikilink
syn match MdEndWikilink '\]\]' conceal cchar= containedin=MdWikilink

" References
syn match MdReference '!\?\[.*\](.*)' contains=MdLinkRef,MdLinkBody keepend
syn match MdLinkRef '(.*)' containedin=MdReference contained conceal cchar=¹ containedin=MdReference
syn match MdLinkBody '!\?\[.*\]' contained contains=MdLinkParen,MdLinkBodyContent
syn match MdLinkBodyContent '!\?[^\]\[]*' contained contains=MdLinkParen,MdLinkBodyContent
syn match MdLinkParen '\(!\?\[\|\]\)' conceal contained

" Md checklist
syn match MdCheckboxHead '^\s*-\s\[.\]\s' nextgroup=MdCheckboxTextFilled contains=MdCheckBox
syn match MdCheckBox '-\s\[.\]' contains=MdCheckChar contained
syn match MdCheckChar 'x' conceal cchar=✓ contained
syn match MdCheckChar 'X' conceal cchar=✓ contained
syn match MdCheckChar 'v' conceal cchar=✓ contained

syn match MdCheckboxTextFilled '.*' contained

syn match MdEmptyCheckbox '^\s*-\s\[\s\]\s' contains=MdCheckBox

syn region MdPre start='```' end='```'
syn region MdPre start='`' end='`'

syn match MdBold '__[0-9a-zA-Z\s'"`*_]\+__'  contains=MdBoldMark keepend
syn match MdBold '\*\*[0-9a-zA-Z\s'"`*_]\+\*\*' contains=MdBoldMark keepend
syn match MdBoldMark '__' contained containedin=MdBold cchar= conceal
syn match MdBoldMark '\*\*' contained containedin=MdBold cchar= conceal

syn match MdCoursive '_[0-9a-zA-Z\s'"`]\+_'  contains=MdCoursiveMark keepend
syn match MdCoursive '\*[0-9a-zA-Z\s'"`]\+\*' contains=MdCoursiveMark keepend
syn match MdCoursiveMark '_' contained containedin=MdCoursive cchar= conceal
syn match MdCoursiveMark '\*' contained containedin=MdCoursive cchar= conceal

" Table matching
syn match MdTableRow '^\s*|\([^|]*|\)\+' keepend contains=MdTable,MdPre,MdTableColumn
syn match MdTable '^\s*|\(\s\?:\?-\{3,}:\?\s\?|\)\+' keepend contains=MdTableColumn,MdTableLine
syn match MdTableColumn '|' contained conceal cchar=│
syn match MdTableColumn '|\(-\)\@=' contained containedin=MdTableRow,MdTable  conceal cchar=├
syn match MdTableColumn '\(-\)\@<=|' contained containedin=MdTableRow,MdTable  conceal cchar=┤
syn match MdTableColumn '\(-\)\@<=|\(-\)\@=' contained containedin=MdTableRow,MdTable  conceal cchar=┼
syn match MdTableLine '-' contained containedin=MdTable conceal cchar=─

" Separators
syn match MdSep '^-\{3,\}' keepend contains=MdSepChar
syn match MdSep '^\*\{3,\}' keepend contains=MdSepChar
syn match MdSep '^_\{3,\}' keepend contains=MdSepChar
syn match MdSepChar '-' contained conceal cchar=─
syn match MdSepChar '*' contained conceal cchar=─
syn match MdSepChar '_' contained conceal cchar=─

set conceallevel=2
hi Conceal gui=none ctermfg=7
hi link MdH1 htmlH1
hi link MdH2 htmlH2
hi link MdH3 htmlH3
hi link MdH4 htmlH4
hi link MdH5 htmlH5
hi link MdH6 htmlH6
hi link MdQuote Comment
hi link MdDot Conceal
hi link MdNumberedListHeader MdDot
hi link MdWikilink Blue
hi link MdLinkBodyContent Blue
hi link MdLinkRef htmlLink
hi link MdLinkParen Conceal
hi link MdCheckBox Conceal
hi link MdCheckChar Conceal
hi link MdCheckboxTextFilled Comment
hi link MdPre String
hi link MdTable Conceal
hi link MdTableColumn Conceal
hi MdCoursieve cterm=italic gui=italic 
hi link MdBold htmlBold
