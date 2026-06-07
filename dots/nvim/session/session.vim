let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
doautoall SessionLoadPre
silent only
silent tabonly
cd ~/rtm-migration
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
set shortmess+=aoO
badd +62 src/CPU/geometry.py
badd +36 ~/rtm-migration/cpp/geometry.hpp
badd +19 cpp/geometry.cpp
argglobal
%argdel
edit cpp/geometry.cpp
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
let &splitbelow = s:save_splitbelow
let &splitright = s:save_splitright
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe 'vert 1resize ' . ((&columns * 66 + 67) / 134)
exe 'vert 2resize ' . ((&columns * 67 + 67) / 134)
argglobal
balt ~/rtm-migration/cpp/geometry.hpp
setlocal foldmethod=manual
setlocal foldexpr=0
setlocal foldmarker={{{,}}}
setlocal foldignore=#
setlocal foldlevel=99
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldenable
silent! normal! zE
sil! 12,16fold
sil! 26,28fold
sil! 20,31fold
sil! 35,37fold
let &fdl = &fdl
let s:l = 33 - ((24 * winheight(0) + 17) / 34)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 33
normal! 0
wincmd w
argglobal
if bufexists(fnamemodify("src/CPU/geometry.py", ":p")) | buffer src/CPU/geometry.py | else | edit src/CPU/geometry.py | endif
if &buftype ==# 'terminal'
  silent file src/CPU/geometry.py
endif
balt ~/rtm-migration/cpp/geometry.hpp
setlocal foldmethod=manual
setlocal foldexpr=0
setlocal foldmarker={{{,}}}
setlocal foldignore=#
setlocal foldlevel=99
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldenable
silent! normal! zE
sil! 4,5fold
sil! 10,16fold
sil! 20,21fold
sil! 22,23fold
sil! 24,25fold
sil! 18,25fold
sil! 30,32fold
sil! 33,35fold
sil! 39,41fold
sil! 42,44fold
sil! 27,46fold
sil! 48,52fold
sil! 54,58fold
sil! 60,64fold
sil! 78,80fold
sil! 84,89fold
sil! 83,90fold
sil! 67,90fold
sil! 66,90fold
sil! 9,90fold
let &fdl = &fdl
4
sil! normal! zc
9
sil! normal! zo
18
sil! normal! zo
27
sil! normal! zo
66
sil! normal! zo
67
sil! normal! zo
78
sil! normal! zc
83
sil! normal! zo
84
sil! normal! zc
83
sil! normal! zc
67
sil! normal! zc
66
sil! normal! zc
let s:l = 62 - ((18 * winheight(0) + 17) / 34)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 62
normal! 0
wincmd w
exe 'vert 1resize ' . ((&columns * 66 + 67) / 134)
exe 'vert 2resize ' . ((&columns * 67 + 67) / 134)
tabnext 1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20
let &shortmess = s:shortmess_save
let &winminheight = s:save_winminheight
let &winminwidth = s:save_winminwidth
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
set hlsearch
nohlsearch
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
