return {
  {
    'zaldih/themery.nvim',
    lazy = false,
    config = function()
      require('themery').setup {
        themes = {
          'tokyonight-storm',
          'tokyonight-moon',
          'tokyonight-night',
          'catppuccin-frappe',
          'catppuccin-macchiato',
          'catppuccin-mocha',
          'kanagawa-wave',
          'kanagawa-dragon',
          'kanagawa-paper-ink',
          'rose-pine-main',
          'rose-pine-moon',
          'vague',
          'everforest',
          'gruvbox',
          'gruvbox-material',
          'sonokai',
          'edge',
          'xcodelight',
          'xcodelighthc',
          'xcodedark',
          'xcodedarkhc',
          'xcodewwdc',
        }, -- Your list of installed colorschemes.
        livePreview = true, -- Apply theme while picking. Default to true.
      }
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
