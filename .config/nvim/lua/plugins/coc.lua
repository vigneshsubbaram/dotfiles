return {
    'neoclide/coc.nvim',
    branch = 'release',
    config = function()
        vim.g.coc_global_extensions = {
            'coc-pyright',
            '@yaegassy/coc-ruff',
            'coc-sh',
            '@yaegassy/coc-marksman',
            'coc-markdownlint',
            'coc-snippets',
            'coc-json'
        }

        -- Setup standard VSCode-like keybinds using Vimscript
        vim.cmd([[
            " Use Tab for trigger completion with characters ahead and navigate
            inoremap <silent><expr> <TAB>
                  \ coc#pum#visible() ? coc#pum#next(1) :
                  \ CheckBackspace() ? "\<Tab>" :
                  \ coc#refresh()
            inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

            " Make <CR> (Enter) to accept selected completion item
            inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                                  \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

            function! CheckBackspace() abort
              let col = col('.') - 1
              return !col || getline('.')[col - 1]  =~# '\s'
            endfunction

            " Use K to show documentation in preview window
            nnoremap <silent> K :call ShowDocumentation()<CR>
            function! ShowDocumentation()
              if CocAction('hasProvider', 'hover')
                call CocActionAsync('doHover')
              else
                call feedkeys('K', 'in')
              endif
            endfunction
        ]])
    end
}
