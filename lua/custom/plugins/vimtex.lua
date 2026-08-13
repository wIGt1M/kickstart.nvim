return {
  'lervag/vimtex',
  ft = { 'tex' },
  init = function()
    vim.g.vimtex_view_method = 'zathura'
    vim.g.vimtex_view_general_viewer = 'zathrua'
    vim.g.vimtex_view_general_options = '--synctex-forward @line:@col:@tex @pdf'
    vim.g.vimtex_view_forward_search_on_start = 1
    vim.g.vimtex_compiler_method = 'latexmk'
    vim.g.vimtex_compiler_latexmk = {
      aux_dir = '.aux',
      --aux_dir = 'build/aux',
      --out_dir = 'build',
      options = {
        '-pdf',
        '-shell-escape',
        'interaction=nonstopmode',
        '-synctex=1',
        '-file-line-error',
      },
    }
    vim.g.vimtex_quickfix_ignore_filters = {
      'Underfull',
      'Overfull',
    }
    vim.g.vimtex_mappings_enabled = 0
    vim.g.vimtex_syntax_enabled = 1
    vim.g.vimtex_syntax_conceal = {
      accents = 1,
      ligatures = 1,
      cites = 1,
      fancy = 1,
      spacing = 1,
      greek = 1,
      math_bounds = 1,
      math_delimiters = 1,
      math_fracs = 1,
      math_super_sub = 1,
      math_symbols = 1,
    }
  end,
  lazy = false,
  --config = function()
  --  vim.api.nvim_create_autocmd('FileType', {
  --    pattern = 'tex',
  --    callback = function()
  --      local map = function(keys, cmd, desc)
  --        vim.keymap.set('n', keys, cmd, { buffer = true, desc = 'VimTex: ' .. desc })
  --      end

  --      map('<leader>ll', '<cmd>VimtexCompile<cr>', 'Compile')
  --      map('<leader>lv', '<cmd>VimtexView<cr>', 'View')
  --      map('<leader>lk', '<cmd>VimtexStop<cr>', 'StopCompile')
  --    end,
  --  })
  --end,
}
