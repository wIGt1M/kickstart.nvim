return {
  {
    'zaldih/themery.nvim',
    lazy = false,
    config = function()
      require('themery').setup {
        themes = {
          'tokyonight',
          'tokyonight-night',
          'tokyonight-storm',
          'vague',
          'kanagawa',
          'kanagawa-dragon',
          'kanagawa-wave',
          'catppuccin',
          'catppuccin-frappe',
          'catppuccin-macchiato',
          'gruvbox',
          'rose-pine',
          'rose-pine-moon',
          'everforest',
          'monokai',
          'iceberg',
          'horizon',
          'molokai',
          'sonokai',
          'tundra',
          'backpack',
          'moonfly',
        }, -- Your list of installed colorschemes.
        livePreview = true, -- Apply theme while picking. Default to true.
      }
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
