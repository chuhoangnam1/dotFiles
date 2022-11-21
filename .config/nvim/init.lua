local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

vim.cmd [[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]]

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use 'gruvbox-community/gruvbox'

  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'

  use 'editorconfig/editorconfig-vim'
  use { 'junegunn/fzf', run = function() vim.fn.execute('fzf#install') end }
  use 'junegunn/fzf.vim'
  use 'junegunn/vim-peekaboo'
  use 'mattn/emmet-vim'
  use 'scrooloose/nerdtree'
  use 'tpope/vim-commentary'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-obsession'
  use 'tpope/vim-repeat'
  use 'tpope/vim-surround'

  -- Neovim's Treesitter
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  -- Ruby development plugins
  use 'thoughtbot/vim-rspec'
  use 'tpope/vim-rails'
  use 'vim-ruby/vim-ruby'

  -- Javscript/Typescript development plugins
  use 'pangloss/vim-javascript'
  use 'leafgarland/typescript-vim'
  use 'maxmellon/vim-jsx-pretty'
  use 'peitalin/vim-jsx-typescript'
  use 'posva/vim-vue'
  use 'styled-components/vim-styled-components'
  use 'jparise/vim-graphql'

  -- Generic development plugins
  use 'sheerun/vim-polyglot'
  use 'tpope/vim-endwise'
  use 'windwp/nvim-autopairs'

  use { 'neoclide/coc.nvim', branch = 'release' }
end)

-- Set colorscheme
vim.opt.termguicolors = true
vim.cmd [[
  let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
  colorscheme gruvbox
]]

-- Set basic eyecandy settings
vim.opt.colorcolumn = '80'
vim.opt.cursorline = true
vim.opt.scrolloff = 5

vim.opt.splitbelow = true
vim.opt.splitright = true

-- Disable spelling by default
vim.opt.spell = false

-- Disable wordwrap by default
vim.opt.wrap = false

-- Set line number to be relative number
vim.opt.number = true
vim.opt.relativenumber = true

-- Set highlight on search
vim.opt.hlsearch = true

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Decrease update time
vim.opt.updatetime = 250
vim.opt.signcolumn = 'yes'

-- Set completeopt to have a better completion experience
vim.opt.completeopt = 'menuone,noselect'

-- Disable backup and swapfiles
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.writebackup = false

vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.autoindent = true

vim.opt.path = '.'

vim.opt.wildmenu = true
vim.opt.wildignorecase = true
vim.opt.wildignore = {
  '*~',
  '*.o',
  '*.pyc',
  '*.bak',
  '*.exe',
  '*.so',
  '*.dll',
  '*.min.*',
  '*/.git/*',
  '*/.hg/*',
  '*/.svn/*',
  '*/tmp/*',
  '*/log/*',
  '*/node_modules/*'
}

vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.showmatch = true
vim.opt.matchtime = 2

vim.opt.foldenable = true
vim.opt.foldmethod = 'syntax'

vim.opt.exrc = true
vim.opt.secure = true

-- Return to last edit position when opening files
vim.cmd [[
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
]]

-- Automatically create parent directory on save
vim.cmd [[
  function s:MkNonExDir(file, buf)
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
      let dir=fnamemodify(a:file, ':h')
      if !isdirectory(dir)
        call mkdir(dir, 'p')
      endif
    endif
  endfunction
  augroup BWCCreateDir
    autocmd!
    autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
  augroup END
]]

-- Set grepprg and open quickfix when grep
vim.cmd [[
  if executable("ag")
    set grepprg=ag\ --nogroup\ --nocolor\ --ignore-case\ --skip-vcs-ignores\ --column
    set grepformat=%f:%l:%c:%m,%f:%l:%m
  endif
]]

vim.cmd [[
  command! Bclose call BufcloseCloseIt()
  function! BufcloseCloseIt() abort
      let l:currentBufNum = bufnr("%")
      let l:alternateBufNum = bufnr("#")

      if buflisted(l:alternateBufNum)
          buffer #
      else
          bnext
      endif

      if bufnr("%") == l:currentBufNum
          new
      endif

      if buflisted(l:currentBufNum)
          execute("bdelete! ".l:currentBufNum)
      endif
  endfunction
]]

vim.cmd [[
  function! GetBufferList()
    redir =>buflist
    silent! ls!
    redir END
    return buflist
  endfunction
]]

vim.cmd [[
  function! ToggleList(bufname, pfx)
    let buflist = GetBufferList()
    for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
      if bufwinnr(bufnum) != -1
        exec(a:pfx.'close')
        return
      endif
    endfor
    if a:pfx == 'l' && len(getloclist(0)) == 0
        echohl ErrorMsg
        echo "location list is empty."
        return
    endif
    let winnr = winnr()
    exec(a:pfx.'open')
    if winnr() != winnr
      wincmd p
    endif
  endfunction
]]

vim.cmd [[
  command! TrimWhiteSpace call TrimWhiteSpace()
  function! TrimWhiteSpace()
    %s/\s\+$//
    ''
  endfunction
]]

-- Airline configurations
vim.g.airline_powerline_fonts = 0
vim.g.airline_section_b = ""

vim.cmd [[
  if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif

  let g:airline_symbols.crypt = '🔒'
  let g:airline_symbols.colnr = ' col:'
  let g:airline_symbols.linenr = ' line:'
  let g:airline_symbols.maxlinenr = ''
  let g:airline_symbols.paste = 'PASTE'
  let g:airline_symbols.spell = 'SPELL'
  let g:airline_symbols.notexists = '?'
]]

-- NERDtree configurations
vim.g.NERDTreeCaseSensitiveSort = 1
vim.g.NERDTreeNatureSort = 1
vim.g.NERDTreeQuitOnOpen = 1
vim.g.NERDTreeShowHidden = 1
vim.g.NERDTreeWinPos = 'left'
vim.g.NERDTreeWinSize = 36
vim.g.NERDTreeIgnore = {
  '.git',
  '.idea',
  '.DS_Store',
}

-- fzf.vim configurations
vim.cmd [[
  command! -bang -nargs=* Ag
    \ call fzf#vim#ag(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)

  let $FZF_DEFAULT_COMMAND = 'ag --hidden --skip-vcs-ignores -l -g ""'
]]

-- vim-polyglot configurations
vim.g.polyglot_disabled = {
  'autoindent'
}

-- vim-ruby configurations
vim.cmd [[
  let ruby_foldable_groups = 'if def do begin case for { [ % # <<'
]]

require("nvim-autopairs").setup {}

-- nvim-treesitter
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "javascript", "ruby", "go" },
  auto_install = true,
  ignore_install = {},
  indent = {
    enable = false
  },
  highlight = {
    enable = true,
    disable = {},
    disable = function(lang, buf)
      local max_filesize = 100 * 1024
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,
    additional_vim_regex_highlighting = true
  },
  incremental_selection = {
    enable = true,
    disable = {},
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    }
  },
}

require('vim.treesitter.query').set_query(
  'ruby',
  'folds',
  [[
    [
      (method)
      (do_block)
    ] @fold
  ]]
)

---WORKAROUND: fix for treesitter reports 'No folds found'
vim.api.nvim_create_autocmd({'BufEnter','BufAdd','BufNew','BufNewFile','BufWinEnter'}, {
  group = vim.api.nvim_create_augroup('TS_FOLD_WORKAROUND', {}),
  callback = function()
    vim.opt.foldmethod     = 'expr'
    vim.opt.foldexpr       = 'nvim_treesitter#foldexpr()'
  end
})
---ENDWORKAROUND

-- coc-nvim configurations
vim.api.nvim_set_keymap('i', '<expr>', '<CR>', { noremap = true })
vim.cmd [[
  " Make <CR> to accept selected completion item or notify coc.nvim to format
  " <C-g>u breaks current undo, please make your own choice.
  inoremap <expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

  " Use `[g` and `]g` to navigate diagnostics
  " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
  nmap [g <Plug>(coc-diagnostic-prev)
  nmap ]g <Plug>(coc-diagnostic-next)

  " GoTo code navigation.
  nnoremap gd <Plug>(coc-definition)
  nnoremap gy <Plug>(coc-type-definition)
  nnoremap gi <Plug>(coc-implementation)
  nnoremap gr <Plug>(coc-references)

  " Use K to show documentation in preview window.
  nnoremap <silent> K :call ShowDocumentation()<CR>

  function! ShowDocumentation()
    if CocAction('hasProvider', 'hover')
      call CocActionAsync('doHover')
    else
      call feedkeys('K', 'in')
    endif
  endfunction

  " Highlight the symbol and its references when holding the cursor.
  autocmd CursorHold * silent call CocActionAsync('highlight')

  " Symbol renaming.
  nnoremap <leader>rn <Plug>(coc-rename)
]]

-- Remap space as leader key
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Remap Ctrl-Backspace to delete word backward
vim.api.nvim_set_keymap('i', '<M-BS>', '<C-w>', { noremap = true })

-- Remap for dealing with word wrap
vim.api.nvim_set_keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true })
vim.api.nvim_set_keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true })

vim.api.nvim_set_keymap('n', 'S', 'i<CR><esc>', { noremap = true })
vim.api.nvim_set_keymap('', '<C-c>', '<esc>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-c>', '<cmd>e!<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-e>', '<cmd>e#<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-j>', '<cmd>tabprevious<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<cmd>tabnext<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<cmd>Buffers<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-n>', '<cmd>NERDTreeToggle<CR>', { noremap = true })

vim.api.nvim_set_keymap('n', '<leader>fd', '<cmd>Bclose<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>ff', '<cmd>GFiles<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fh', '<cmd>GFiles<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fF', '<cmd>FZF<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fa', '<cmd>Ag<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>ft', '<cmd>CocList symbols<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fm', '<cmd>Marks<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fs', '<cmd>write<CR>', { noremap = true })

vim.api.nvim_set_keymap('n', '<leader>QQ', '<cmd>qa!<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>qq', '<cmd>qa<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>qw', '<cmd>wqa<CR>', { noremap = true })

vim.api.nvim_set_keymap('n', '<leader>ss', '<cmd>setlocal spell!<CR>', { noremap = true })

vim.api.nvim_set_keymap('n', '<leader>w=', '<C-w>=', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>wc', '<C-w>c', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>wh', '<C-w>h', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>wj', '<C-w>j', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>wk', '<C-w>k', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>wl', '<C-w>l', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>wn', '<C-w>n', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>ws', '<C-w>s', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>wv', '<C-w>v', { noremap = true })

vim.api.nvim_set_keymap('n', '<leader>tc', '<cmd>tabclose<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>td', '<cmd>Bclose<CR><cmd>tabclose<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>tk', '<cmd>tabnext<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>tj', '<cmd>tabprevious<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>tn', '<cmd>tabnew<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>ts', '<cmd>tab split<CR>', { noremap = true })

vim.api.nvim_set_keymap('n', '<leader>nc', '<cmd>NERDTreeClose<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>nm', '<cmd>NERDTreeFind<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>nn', '<cmd>NERDTreeToggle<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>nr', '<cmd>NERDTreeRefreshRoot<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>nv', '<cmd>NERDTreeVCS<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>nw', '<cmd>NERDTreeCWD<CR>', { noremap = true })

vim.api.nvim_set_keymap('n', '<leader>config', '<cmd>edit $MYVIMRC<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>reload', '<cmd>source $MYVIMRC<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>vimrc', '<cmd>source .vimrc<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>sort', '<esc>Vapk:sort<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>term', '<cmd>term<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>cwd', '<cmd>lcd %:p:h<CR>', { noremap = true })

vim.api.nvim_set_keymap('n', 'go', 'o<esc>', { noremap = true })
vim.api.nvim_set_keymap('n', 'gO', 'O<esc>', { noremap = true })

vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '[f', '<cmd>previous<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '[l', '<cmd>lprevious<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '[q', '<cmd>cprevious<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '[t', '<cmd>tprevious<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', ']f', '<cmd>next<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', ']l', '<cmd>lnext<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', ']q', '<cmd>cnext<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', ']t', '<cmd>tnext<CR>', { noremap = true })

vim.api.nvim_set_keymap('n', '*', '<cmd>keepjumps normal! mi*`i<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', 'g*', '<cmd>keepjumps normal! mig*`i<CR>', { noremap = true })

vim.api.nvim_set_keymap('n', '<leader>/', '<cmd>noh<CR>', { noremap = true })

vim.api.nvim_set_keymap('n', '<leader>yy', '"+yy', { noremap = true })
vim.api.nvim_set_keymap('v', '<leader>yy', '"+y', { noremap = true })

vim.api.nvim_set_keymap('v', '<leader>specf', '<cmd>call RunCurrentSpecFile()<CR>', { noremap = true })
vim.api.nvim_set_keymap('v', '<leader>specn', '<cmd>call RunNearestSpec()<CR>', { noremap = true })
vim.api.nvim_set_keymap('v', '<leader>specl', '<cmd>call RunLastSpec()<CR>', { noremap = true })
vim.api.nvim_set_keymap('v', '<leader>speca', '<cmd>call RunAllSpec()<CR>', { noremap = true })

vim.api.nvim_set_keymap('c', '<esc>b', '<S-Left>', { noremap = true })
vim.api.nvim_set_keymap('c', '<esc>f', '<S-Right>', { noremap = true })

-- vim: ts=2 sts=2 sw=2 et
