" set the font
set guifont=Menlo:h16
" antialias font
set anti

set transparency=0

" set the color of the ColorColumn
hi ColorColumn guibg=#2d2d2d


"set fuopt+=maxhorz                      " grow to maximum horizontal width on entering fullscreen mode
"macmenu &Edit.Find.Find\.\.\. key=<nop> " free up Command-F
"map <D-f> :set invfu<CR>                " toggle fullscreen mode

if has("gui_macvim")

	macm Window.Select\ Previous\ Tab  key=<D-S-Left>
	macm Window.Select\ Next\ Tab	   key=<D-S-Right>


	" fullscreen options (MacVim only), resized window when changed to fullscreen
	set fuoptions=maxvert,maxhorz
	" remove the toolbar
	set guioptions-=T
	" turn on tabs by default
	set stal=2

	" nnorema <Leader-t>
	" map cmd-t to Command-T
    " macmenu &File.New\ Tab key=<nop>
    " nnoremap <D-t> :CommandT<CR>

	map <leader>g :execute 'TlistToggle'<CR>
	" map cmd-shift-t to TagList
	" macmenu &File.Open\ Tab\.\.\.<Tab>:tabnew key=<nop>
   	" nnoremap <D-T> :TlistToggle<CR>

	map <leader>d :execute 'NERDTreeToggle'<CR>
	" map cmd-shift-o to NERDTree
	" nnoremap <D-O> :NERDTreeToggle<CR>
endif

" C-TAB and C-SHIFT-TAB cycle tabs forward and backward
nmap <c-tab> :tabnext<cr>
imap <c-tab> <c-o>:tabnext<cr>
vmap <c-tab> <c-o>:tabnext<cr>
nmap <c-s-tab> :tabprevious<cr>
imap <c-s-tab> <c-o>:tabprevious<cr>
vmap <c-s-tab> <c-o>:tabprevious<cr>

" C-# switches to tab
nmap <d-1> 1gt
nmap <d-2> 2gt
nmap <d-3> 3gt
nmap <d-4> 4gt
nmap <d-5> 5gt
nmap <d-6> 6gt
nmap <d-7> 7gt
nmap <d-8> 8gt
nmap <d-9> 9gt
