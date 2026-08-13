return {
  {
    'iurimateus/luasnip-latex-snippets.nvim',
    ft = { 'tex' },
    dependencies = { 'L3MON4D3/LuaSnip' },
    config = function()
      require('luasnip-latex-snippets').setup()
      require('luasnip').config.setup {
        enable_autosnippets = true,
      }
    end,
  },
}
