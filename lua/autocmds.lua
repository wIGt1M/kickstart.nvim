local autocmd = vim.api.nvim_create_autocmd

-- Enable spell checking for writing file types
autocmd('FileType', {
  pattern = { 'tex', 'markdown', 'text' },
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = { 'de_20', 'en' }
  end,
})

-- Extra tweaks specifically for LaTeX
autocmd('FileType', {
  pattern = 'tex',
  callback = function()
    -- prevent LaTeX commands from confusing spell checking
    vim.opt_local.iskeyword:remove '\\'

    -- German quotes
    vim.keymap.set('i', '"', '„', { buffer = true })
    vim.keymap.set('i', '„„', '“', { buffer = true })
  end,
})

-- Useful abbreviations for German writing in LaTeX
autocmd('FileType', {
  pattern = 'tex',
  callback = function()
    vim.cmd [[
      iabbrev <buffer> zB z.\,B.
      iabbrev <buffer> dh d.\,h.
      iabbrev <buffer> ua u.\,a.
    ]]
  end,
})
