return {
  { -- You can easily change to a different colorscheme.

    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    'folke/tokyonight.nvim',
    -- priority = 1000, -- Make sure to load this before all the other start plugins.
    --[[config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('tokyonight').setup {
        styles = {
          comments = { italic = false }, -- Disable italics in comments
        },
      }

      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load
      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      vim.cmd.colorscheme 'tokyonight-night'
    end,
    --]]
  },

  {
    'vague-theme/vague.nvim',
    priority = 1000,
    config = function()
      require('vague').setup {
        styles = {
          comments = { italic = false },
        },
        on_highlights = function(hl, colors)
          hl.Pmenu = { fg = colors.fg }
          hl.PmenuSel = { fg = colors.constant, bg = colors.line }
          hl.PmenuBorder = { fg = colors.floatBorder }
        end,
      }
      vim.cmd.highlight 'statusline guibg=NONE'
    end,
    --[[
    priority = 1000,
    config = function()
      require('vague').setup { --{ transparent = true },
        styles = { comments = { italic = false } },
      }
      vim.cmd.colorscheme 'vague'
      vim.cmd.highlight 'statusline guibg=NONE'
    end,
    --]]
  },

  { 'rebelot/kanagawa.nvim' },

  { 'catppuccin/nvim' },

  { 'sainnhe/gruvbox-material' },

  --{ 'morhetz/gruvbox' },

  { 'thesimonho/kanagawa-paper.nvim' },

  {
    'rose-pine/neovim',
    config = function()
      require('rose-pine').setup {
        styles = {
          italic = false,
          --transparency = true,
        },
      }
    end,
  },

  {
    'ellisonleao/gruvbox.nvim',
    config = function()
      require('gruvbox').setup {
        contrast = '',
        italic = {
          strings = false,
          emphasis = false,
          commecnts = true,
          operators = false,
          folds = true,
        },
      }
    end,
  },

  --{
  --  'neanias/everforest-nvim',
  --  config = function()
  --    require('everforest').setup {
  --      background = 'medium',
  --      ui_contrast = 'high',
  --    }
  --  end,
  --},

  {
    'sainnhe/sonokai',
    init = function()
      vim.g.sonokai_style = 'andromeda'
      vim.g.sonokai_diagnostic_text_highlight = 1
      vim.g.sonokai_diadnostic_line_highlight = 1
    end,
  },

  {
    'sainnhe/everforest',
    init = function()
      vim.g.everforest_ui_contrast = 'high'
      vim.g.everforest_diagnostic_text_highlight = 1
      vim.g.everforest_diadnostic_line_highlight = 1
    end,
  },

  {
    'sainnhe/edge',
    init = function()
      vim.g.edge_style = 'aura'
      vim.g.edge_diagnostic_text_highlight = 1
      vim.g.edge_diadnostic_line_highlight = 1
    end,
  },

  --{ 'w0ng/vim-hybrid' },

  --{ 'yonatan-perel/lake-dweller.nvim' },

  --{ 'filipjanevski/0x96f.nvim' },

  --{ 'smit4k/shale.nvim' },

  --{ 'dikiaap/minimalist' },

  --{ 'axvr/photon.vim' },

  { 'lunacookies/vim-colors-xcode' },

  --{ 'embark-theme/vim' },

  --{ 'metalelf0/jellybeans-nvim' },

  --{ 'JoosepAlviste/palenightfall.nvim' },

  --{ 'yazeed1s/oh-lucy.nvim' },

  --{ 'armannikoyan/rusty' },

  --{ 'Ardakilic/vim-tomorrow-night-theme' },

  --{ 'datsfilipe/min-theme.nvim' },

  --{ 'samharju/synthweave.nvim' },

  --{ 'LunarVim/synthwave84.nvim' },

  --{ 'lettertwo/laserwave.nvim' },

  --{ 'RedsXDD/neopywal.nvim' },

  --{ 'github-main-user/lytmode.nvim' },

  --{ 'ydkulks/cursor-dark.nvim' },

  --{ 'mrtazz/molokai.vim' },

  --{ 'joshdick/onedark.vim' },

  --{ 'NLKNguyen/papercolor-theme' },

  --{ 'dracula/vim' },

  --{ 'loctvl842/monokai-pro.nvim' },

  --{ 'liuchengxu/space-vim-dark' },

  --{ 'NTBBloodbath/doom-one.nvim' },

  --{ 'colepeters/spacemacs-theme.vim' },

  --{ 'GustavoPrietoP/doom-themes.nvim' },

  --{ 'tanvirtin/monokai.nvim' },

  --{ 'cocopon/iceberg.vim' },

  --{ 'akinsho/horizon.nvim' },

  --{ 'tomasr/molokai' },

  --{ 'sam4llis/nvim-tundra' },

  --{ 'Mitch1000/backpack.nvim' },

  --{ 'bluz71/vim-moonfly-colors' },

  --{ 'uloco/bluloco.nvim' },
}
-- vim: ts=2 sts=2 sw=2 et
