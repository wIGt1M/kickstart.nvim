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
          'rose-pine-main',
          'rose-pine-moon',
          'vague',
          'kanagawa-paper-ink',
          'lake-dweller',
          '0x96f',
          'hybrid',
          'doom-horizon',
          'doom-laserwave',
          'laserwave',
          'laserwave-hi_c',
          'spacemacs-theme',
        }, -- Your list of installed colorschemes.
        livePreview = true, -- Apply theme while picking. Default to true.
      }
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
