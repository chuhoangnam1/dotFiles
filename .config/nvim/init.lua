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
  use 'scrooloose/nerdtree'
  use 'tpope/vim-commentary'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-obsession'
  use 'tpope/vim-repeat'
  use 'tpope/vim-surround'
  use 'milkypostman/vim-togglelist'

  -- Neovim's Treesitter
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  -- Ruby development plugins
  use 'thoughtbot/vim-rspec'
  use 'tpope/vim-rails'
  use 'vim-ruby/vim-ruby'
  use 'kana/vim-textobj-user'
  use 'rhysd/vim-textobj-ruby'
  use 'nelstrom/vim-textobj-rubyblock'

  -- Javscript/Typescript development plugins
  use 'pangloss/vim-javascript'
  use 'leafgarland/typescript-vim'
  use 'maxmellon/vim-jsx-pretty'
  use 'peitalin/vim-jsx-typescript'
  use 'posva/vim-vue'
  use 'styled-components/vim-styled-components'
  use 'jparise/vim-graphql'

  -- Golang development plugins
  use { 'fatih/vim-go', run = ':GoUpdateBinaries' }

  -- Generic development plugins
  use 'sheerun/vim-polyglot'
  use 'tpope/vim-endwise'
  use 'windwp/nvim-autopairs'

  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'
  use 'neovim/nvim-lspconfig'

  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'

  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'
end)

-- Set colorscheme
vim.opt.termguicolors = true
vim.cmd [[
  let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
  colorscheme gruvbox
]]
vim.g.gruvbox_bold = 1
vim.g.gruvbox_italic = 1
vim.g.gruvbox_contrast_light = 1

-- Set basic eyecandy settings
vim.opt.colorcolumn = '120'
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

-- Sign column
vim.opt.signcolumn = 'no'

vim.opt.numberwidth = 5

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
vim.opt.foldnestmax = 3
-- vim.opt.foldmethod = 'syntax'

vim.opt.exrc = true
vim.opt.secure = true

vim.cmd [[
  command! -nargs=+ F execute 'silent grep!' <q-args> | cw | redraw!
]]

-- eyecandy for various filetypes
vim.cmd [[
  autocmd FileType help set relativenumber
  autocmd FileType make set autoindent noexpandtab softtabstop=4 tabstop=4 shiftwidth=4
  autocmd FileType proto set autoindent noexpandtab softtabstop=4 tabstop=4 shiftwidth=4
  autocmd FileType ruby set iskeyword+=?
]]

-- quickfix window mappings
vim.cmd [[
  autocmd FileType qf nnoremap <buffer> <CR> <CR>:cclose<CR>
  autocmd FileType qf nnoremap <ESC> :cclose<CR>
]]


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
    " set grepprg=ag\ --nogroup\ --nocolor\ --ignore-case\ --skip-vcs-ignores\ --column
    " set grepprg=ag\ --vimgrep\ $*
    set grepprg=ag\ --nogroup\ --nocolor\ --ignore-case\ --skip-vcs-ignores\ --column\ --vimgrep\ $*
    set grepformat=%f:%l:%c:%m,%f:%l:%m

    " autocmd FileType go set grepprg=ag\ --nogroup\ --nocolor\ --ignore-case\ --skip-vcs-ignores\ --column\ --ignore=*_test.go\
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
  command! TrimWhiteSpace call TrimWhiteSpace()
  function! TrimWhiteSpace()
    %s/\s\+$//
    ''
  endfunction
]]

vim.cmd [[
  let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']
  let g:EditorConfig_disable_rules = ['max_line_length']
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
vim.g.NERDTreeShowLineNumbers=1
vim.g.NERDTreeWinPos = 'left'
vim.g.NERDTreeWinSize = 64
vim.g.NERDTreeIgnore = {
  '.git',
  '.idea',
  '.DS_Store',
}

-- fzf.vim configurations
vim.cmd [[
  command! -bang -nargs=* Ag
    \ call fzf#vim#ag(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)

  let $FZF_DEFAULT_COMMAND = 'ag --hidden --skip-vcs-ignores --follow -l -g ""'
]]

-- vim-polyglot configurations
vim.g.polyglot_disabled = {
  'autoindent'
}

-- vim-ruby configurations
vim.cmd [[
  let ruby_foldable_groups = 'def'
]]

-- vim-go configurations
vim.cmd [[
  let g:go_list_autoclose = 0

  autocmd FileType go nnoremap gI :GoImplements<CR>:lopen<CR>
  autocmd FileType go nnoremap gR :GoCallers<CR>:lopen<CR>
]]

require("nvim-autopairs").setup {}

-- nvim-treesitter
require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "bash",
    "css",
    "csv",
    "dockerfile",
    "go",
    "gomod",
    "gosum",
    "html",
    "javascript",
    "json",
    "json5",
    "make",
    "markdown",
    "python",
    "query",
    "ruby",
    "scss",
    "typescript",
  },
  auto_install = true,
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

-- https://github.com/nvim-treesitter/nvim-treesitter/blob/master/queries/ruby/folds.scm
require('vim.treesitter.query').set(
  'ruby',
  'folds',
  [[
    [
      (method)
    ] @fold
  ]]
)

-- https://github.com/nvim-treesitter/nvim-treesitter/blob/master/queries/go/folds.scm
require('vim.treesitter.query').set(
  'go',
  'folds',
  [[
    [
      (function_declaration)
      (import_declaration)
      (method_declaration)
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

-- mason & mason-lspconfig configuration
require('mason').setup()
require('mason-lspconfig').setup {
  ensure_installed = {
    'eslint',
    'gopls',
    'jsonls',
    'ts_ls',
    'ruby_lsp',
    'rubocop'
  },
}

-- nvim-lspconfig configruration
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require 'lspconfig'
local on_attach = function(_, bufnr)
  -- vim.api.nvim_buf_set_option(0, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { buffer = bufnr, noremap = true, silent = true }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  vim.keymap.set('n', 'gt', vim.lsp.buf.document_symbol, opts)
  vim.keymap.set('n', 'gT', vim.lsp.buf.workspace_symbol, opts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
end

lspconfig.gopls.setup {
  on_attach = on_attach(),
  capabilities = capabilities,
}
lspconfig.jsonls.setup {
  on_attach = on_attach(),
  capabilities = capabilities,
}
lspconfig.ts_ls.setup {
  on_attach = on_attach(),
  capabilities = capabilities,
}
lspconfig.solargraph.setup {
  on_attach = on_attach(),
  capabilities = capabilities,
  settings = {
    solargraph = {
      autoformat = false,
      completion = true,
      diagnostic = false,
      diagnostics = true,
      folding = true,
      formatting = false,
      references = true,
      rename = true,
      symbols = true
    }
  }
}
lspconfig.rubocop.setup {
  on_attach = on_attach(),
  capabilities = capabilities,
}
-- lspconfig.ruby_lsp.setup {
--   on_attach = on_attach(),
--   capabilities = capabilities,
-- }

local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<CR>'] = cmp.mapping.confirm({select = false}),
    ['<C-c>'] = cmp.mapping.abort(),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'nvim_lsp_document_symbol' },
    { name = 'cmp-nvim-lsp-signature-help' },
    { name = 'cmp-buffer' },
    { name = 'vsnip' },
  },
}

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
-- vim.api.nvim_set_keymap('n', '<C-r>', '<cmd>e#<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-j>', '<cmd>tabprevious<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<cmd>tabnext<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<cmd>Buffers<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-m>', '<cmd>Marks<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-n>', '<cmd>NERDTreeToggle<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-n>', '<cmd>NERDTreeToggle<CR>', { noremap = true })

-- vim.api.nvim_set_keymap('n', '<C-e>', '5<C-e>', { noremap = true })
-- vim.api.nvim_set_keymap('n', '<C-y>', '5<C-y>', { noremap = true })

vim.api.nvim_set_keymap('n', '<leader>fd', '<cmd>Bclose<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fD', '<cmd>bufdo bd<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fc', '<cmd>Bclose<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fs', '<cmd>write<CR>', { noremap = true })

-- vim.api.nvim_set_keymap('n', '<leader>ff', '<cmd>FZF<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>ff', '<cmd>Files<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fF', '<cmd>GFiles<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fa', '<cmd>Ag<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>ft', '<cmd>BTags<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fT', '<cmd>Tags<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fm', '<cmd>Marks<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fj', '<cmd>Jumps<CR>', { noremap = true })

vim.api.nvim_set_keymap('n', '<leader>QQ', '<cmd>qa!<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>qq', '<cmd>qa<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>qw', '<cmd>wqa<CR>', { noremap = true })

vim.api.nvim_set_keymap('n', '<leader>ss', '<cmd>setlocal spell!<CR>', { noremap = true })

vim.api.nvim_set_keymap('n', '<leader>w=', '<C-w>=', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>wc', '<C-w>c', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>wd', '<C-w>c', { noremap = true })
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
vim.api.nvim_set_keymap('n', '<leader>tn', '<cmd>$tabnew<CR>', { noremap = true })
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

vim.api.nvim_set_keymap('n', '[f', '<cmd>previous<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '[l', '<cmd>lprevious<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '[q', '<cmd>cprevious<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '[t', '<cmd>tprevious<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', ']f', '<cmd>next<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', ']l', '<cmd>lnext<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', ']q', '<cmd>cnext<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', ']t', '<cmd>tnext<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '\\l', '<cmd>call ToggleLocationList()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '\\q', '<cmd>call ToggleQuickfixList()<CR>', { noremap = true })

vim.api.nvim_set_keymap('n', '*', '<cmd>keepjumps normal! mig*`i<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', 'g*', '<cmd>keepjumps normal! mi*`i<CR>', { noremap = true })

vim.api.nvim_set_keymap('n', '<leader>/', '<cmd>noh<CR>', { noremap = true })

vim.api.nvim_set_keymap('n', '<leader>yl', '<cmd>let @* = join([expand(\'%\'),  line(".")], \':\')<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>yy', '"+yy', { noremap = true })
vim.api.nvim_set_keymap('v', '<leader>yy', '"+y', { noremap = true })

vim.api.nvim_set_keymap('c', '<esc>b', '<S-Left>', { noremap = true })
vim.api.nvim_set_keymap('c', '<esc>f', '<S-Right>', { noremap = true })

-- vim: ts=2 sts=2 sw=2 et
