-- =============================================================================
-- LaTeX + German Spellchecking setup for kickstart.nvim
-- Place this file at: ~/.config/nvim/lua/custom/plugins/latex.lua
--
-- Compatible with both nvim-cmp AND blink.cmp (auto-detected).
-- Safe to add alongside an existing LuaSnip configuration.
--
-- Prerequisites (install on your system):
--   - A TeX distribution: texlive-full (Arch/Debian) or MiKTeX (Windows)
--   - latexmk:   usually bundled with texlive
--   - texlab:    cargo install texlab   OR   download binary from GitHub
--   - aspell:    sudo apt install aspell aspell-de  (Debian/Ubuntu)
--                sudo pacman -S aspell aspell-de     (Arch)
--   - (optional) zathura or evince as PDF viewer
-- =============================================================================

return {

  -- ─────────────────────────────────────────────────────────────────────────
  -- 1. VimTeX – the backbone of LaTeX editing in Neovim
  -- ─────────────────────────────────────────────────────────────────────────
  {
    'lervag/vimtex',
    lazy = false, -- must load at startup so filetype detection works
    init = function()
      -- ── Viewer ──────────────────────────────────────────────────────────
      -- Change "zathura" to "evince", "okular", "skim" (macOS), etc.
      vim.g.vimtex_view_method = 'skim'
      --vim.g.latex_view_general_viewer = 'skim'
      vim.g.vimtex_view_skim_sync = 1
      vim.g.vimtex_view_skim_activate = 1

      -- ── Compiler ────────────────────────────────────────────────────────
      vim.g.vimtex_compiler_method = 'latexmk'
      vim.g.vimtex_compiler_latexmk = {
        aux_dir = './aux',
        out_dir = './aux',
        callback = 1,
        continuous = 1,
        executable = 'latexmk',
        options = {
          '-pdf',
          '-shell-escape',
          --'-verbose',
          --'-file-line-error',
          '-synctex=1',
          -- '-interaction=errorstopmode',
          '-interaction=nonstopmode',
          '-emulate-aux-dir',
          --'-auxdir=aux',
          --'-outdir=aux',
          '-f',
        },
      }

      -- ── Common VimTeX keymaps (localleader = \ by default) ──────────────
      --   <localleader>ll  → compile
      --   <localleader>lv  → open PDF / forward search
      --   <localleader>lk  → kill compiler
      --   <localleader>le  → quickfix errors
      --   <localleader>lc  → clean aux files
      --   <localleader>lt  → table of contents

      -- ── Syntax highlighting: VimTeX, NOT Treesitter ─────────────────────
      -- VimTeX ships its own syntax engine and several features (mathzone
      -- detection, text objects like <plug>(vimtex-i$), conceal, etc.) rely
      -- on Vim's legacy :syntax parser. If Treesitter highlighting is active
      -- for the buffer, those features break or behave inconsistently.
      -- kickstart's nvim-treesitter (main branch) config may already skip
      -- attaching the "latex" parser via its own `ts_disabled` table, but
      -- that depends on `vim.treesitter.language.get_lang()` correctly
      -- mapping the "tex"/"plaintex" filetypes to the "latex" parser name,
      -- which isn't always reliable. We don't rely on that: the buffer-local
      -- FileType autocmd below explicitly stops Treesitter for these
      -- filetypes and re-enables legacy :syntax so VimTeX is in full control.
      vim.g.vimtex_syntax_enabled = 1
      vim.g.vimtex_complete_enabled = 0 -- omnifunc fallback (should be disabled)
      vim.g.vimtex_matchparen_enabled = 1
      vim.g.vimtex_indent_enabled = 1
      vim.g.vimtex_log_ignore = { 'Skipping fenced code block' }
      vim.g.vimtex_mappings_enabled = true
      vim.g.vimtex_quickfix_mode = 0
      vim.g.vimtex_compiler_silent = 0
      vim.g.vimtex_syntax_conceal = {
        accents = 0,
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
        sections = 0,
        styles = 1,
      }
      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('LatexBufOpts', { clear = true }),
        pattern = { 'tex', 'plaintex', 'latex' },
        desc = 'German spellcheck + sane defaults for LaTeX buffers',
        callback = function(ev)
          local o = vim.opt_local

          -- Syntax engine ---------------------------------------------------
          -- Stop any Treesitter highlighter that may have attached to this
          -- buffer (regardless of how it got attached) and fall back to
          -- Vim's legacy :syntax, which is what VimTeX's syntax/tex.vim
          -- plugs into. This must run after Treesitter's own FileType
          -- autocmd, which is the case as long as this plugin spec loads
          -- after nvim-treesitter (true by default for `lazy = false`
          -- plugins processed in the order lazy.nvim resolves them; if you
          -- ever see Treesitter highlighting re-appear, wrap this call in
          -- `vim.schedule(function() ... end)` to push it to the back of
          -- the event queue).
          pcall(vim.treesitter.stop, ev.buf)
          vim.bo[ev.buf].syntax = 'ON'

          -- Encoding  --------------------------------------------------------
          o.encoding = 'utf-8'
          o.fileencoding = 'utf-8'
          o.fileencodings = { 'utf-8' }
          o.lazyredraw = true

          -- Spell --------------------------------------------------------
          o.spell = true
          o.spelllang = { 'de_20', 'en' } -- change to "de_de,en_us" for mixed docs

          -- Layout -------------------------------------------------------
          --o.textwidth = 100
          --o.formatoptions:append 't'
          o.wrap = true
          o.linebreak = true -- break at word boundaries, not mid-word

          -- Conceal (hides verbose LaTeX markup for cleaner reading) ------
          o.conceallevel = 1

          -- Indentation --------------------------------------------------
          o.expandtab = true
          o.shiftwidth = 2
          o.tabstop = 2
        end,
      })
    end,
    config = function()
      -- Register snippets once Neovim is fully started
      vim.api.nvim_create_autocmd('User', {
        pattern = 'VeryLazy',
        once = true,
        callback = function()
          -- Guard: only proceed if LuaSnip is actually installed
          local ok, ls = pcall(require, 'luasnip')
          if not ok then
            return
          end

          local s = ls.snippet
          local t = ls.text_node
          local i = ls.insert_node
          local f = ls.function_node
          local fmt = require('luasnip.extras.fmt').fmt

          ls.add_snippets('tex', {
            -- \begin{} … \end{}
            s('beg', fmt('\\begin{{{1}}}\n\t{2}\n\\end{{{1}}}', { i(1, 'environment'), i(2) }, { repeat_duplicates = true })),
            -- \begin{frame} ... \end{frame}
            s('frame', fmt('\\begin{{frame}}{{{}}}\n\t{}\n\\end{{frame}}', { i(1, 'Titel'), i(2) })),
            -- Inline math
            s('mk', fmt('${}$', { i(1) })),
            -- Display math
            s('dm', fmt('\\[\n\t{}\n\\]', { i(1) })),
            -- \frac
            s('fr', fmt('\\frac{{{}}}{{{}}}', { i(1, 'num'), i(2, 'denom') })),
            -- German quotation marks  ,,Wort``
            s('qq', fmt('\\glqq{}\\grqq{}~', { i(1), t '' })),
            -- \textbf / \emph
            s('bf', fmt('\\textbf{{{}}}', { i(1) })),
            s('tt', fmt('\\texttt{{{}}}', { i(1) })),
            s('it', fmt('\\textit{{{}}}', { i(1) })),
            s('em', fmt('\\emph{{{}}}', { i(1) })),
            s('cal', fmt('\\mathcal{{{}}}', { i(1) })),
            s('rm', fmt('\\mathrm{{{}}}', { i(1) })),
            s('bb', fmt('\\mathbb{{{}}}', { i(1) })),
            -- itemize / enumerate
            s('ul', fmt('\\begin{{itemize}}\n\t\\item {}\n\\end{{itemize}}', { i(1) })),
            s('ol', fmt('\\begin{{enumerate}}\n\t\\item {}\n\\end{{enumerate}}', { i(1) })),
            -- \label / \ref
            s('lbl', fmt('\\label{{{}}}', { i(1) })),
            s('ref', fmt('\\ref{{{}}}', { i(1) })),
            -- minted inline for python
            s('mip', fmt('\\mintinline{{python}}{{{}}}', { i(1) })),
          }, { key = 'latex_custom' }) -- key prevents duplicate registration on reload
        end,
      })
    end,
  },

  -- ─────────────────────────────────────────────────────────────────────────
  -- 2. LSP – texlab
  -- ─────────────────────────────────────────────────────────────────────────
  -- Merges texlab into whatever nvim-lspconfig servers kickstart configures,
  -- so your existing LSP setup is untouched.
  -- Also add "texlab" to mason's ensure_installed in your main init.lua.
  {
    'neovim/nvim-lspconfig',
    opts = function(_, opts)
      opts.servers = opts.servers or {}
      opts.servers.texlab = {
        settings = {
          texlab = {
            build = {
              executable = 'latexmk',
              args = { '-pdf', '-shell-escape', '-interaction=nonstopmode', '-synctex=1', '%f' },
              onSave = true,
              forwardSearchAfter = false,
            },
            forwardSearch = {
              executable = '',
              args = { '--synctex-forward', '%l:1:%f', '%p' },
            },
            chktex = {
              onOpenAndSave = true,
              onEdit = false,
            },
            completion = {
              preferLatexCommands = true,
            },
            diagnosticsDelay = 300,
            formatterLineLength = 100,
            latexindent = { modifyLineBreaks = false },
          },
        },
      }
      return opts
    end,
  },

  -- ─────────────────────────────────────────────────────────────────────────
  -- 4. Completion – cite/label source, compatible with BOTH engines
  --
  --    blink.cmp  → uses blink-cmp-latex (native blink source) for unicode
  --                 symbols, plus the documented `luasnip` snippet preset
  --                 so LuaSnip expansion works through blink's own engine
  --                 (see https://main.cmp.saghen.dev/configuration/snippets#luasnip)
  --    nvim-cmp   → uses cmp-vimtex
  --
  --    Only the block matching your actual completion engine will activate.
  -- ─────────────────────────────────────────────────────────────────────────

  -- 4a. blink.cmp path ──────────────────────────────────────────────────────
  {
    'saghen/blink.cmp',
    optional = true,
    dependencies = {
      { 'erooke/blink-cmp-latex', dependencies = { 'lervag/vimtex' } },
      -- BibTeX citation-key completion (\cite{, \textcite{, etc). Scoped to
      -- tex/plaintex only below, even though upstream also supports
      -- markdown/rmd/typst by default.
      { 'krissen/blink-cmp-bibtex' },
    },
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      opts.sources.providers = opts.sources.providers or {}

      -- Per current blink-cmp-latex docs (github.com/erooke/blink-cmp-latex):
      -- name/module/opts.insert_command is still the full set of supported
      -- options, nothing else to add or remove here.
      opts.sources.providers.latex = {
        name = 'Latex',
        module = 'blink-cmp-latex',
        opts = {
          insert_command = true, -- insert \vdash instead of ⊢
        },
      }

      -- Per current blink-cmp-bibtex docs (github.com/krissen/blink-cmp-bibtex):
      -- restrict `filetypes` to LaTeX only (default also includes markdown,
      -- rmd, typst). It auto-discovers .bib files from \addbibresource{} /
      -- \bibliography{} in the buffer, so no `files` list is required if
      -- your .bib lives alongside your .tex project. Add `global_files` if
      -- you keep a master bibliography outside the project directory, e.g.
      --   global_files = { vim.fn.expand('~/bibliography/master.bib') }
      opts.sources.providers.bibtex = {
        name = 'BibTeX',
        module = 'blink-cmp-bibtex',
        min_keyword_length = 2,
        score_offset = 10,
        async = true,
        opts = {
          filetypes = { 'tex', 'plaintex' },
        },
      }

      opts.sources.default = {
        'lsp',
        'snippets',
        'path',
        'buffer',
      }

      opts.sources.per_filetype = opts.sources.per_filetype or {}
      opts.sources.per_filetype.tex = {
        'lsp',
        'latex',
        'bibtex',
        'snippets',
        'buffer',
      }

      -- ✅ Use the documented LuaSnip preset instead of a hand-rolled
      -- `snippets.expand` function. The custom `lsp_expand` wiring used in
      -- older configs has been superseded by this preset, which wires up
      -- expand/jump/active for you and matches the current docs at
      -- https://main.cmp.saghen.dev/configuration/snippets#luasnip
      opts.snippets = { preset = 'luasnip' }

      return opts
    end,
  },

  -- 4b. nvim-cmp path ───────────────────────────────────────────────────────
  --{
  --  'hrsh7th/nvim-cmp',
  --  optional = true, -- only applies when nvim-cmp is in your setup
  --  dependencies = {
  --    { 'micangl/cmp-vimtex', dependencies = { 'lervag/vimtex' } },
  --  },
  --  opts = function(_, opts)
  --    -- Filetype-specific sources; existing sources from kickstart are kept
  --    -- by using cmp's filetype override rather than replacing the global list.
  --    local cmp = require 'cmp'
  --    cmp.setup.filetype('tex', {
  --      sources = cmp.config.sources {
  --        { name = 'vimtex' }, -- \cite, \ref, \label
  --        { name = 'luasnip' },
  --        { name = 'nvim_lsp' },
  --        { name = 'buffer' },
  --      },
  --    })
  --  end,
  --},

  -- ─────────────────────────────────────────────────────────────────────────
  -- 4.5. Telescope – BibTeX picker, scoped to LaTeX
  -- ─────────────────────────────────────────────────────────────────────────
  -- :Telescope bibtex opens a picker over your .bib entries. `context = true`
  -- makes it parse \bibliography{...} / \addbibresource{...} out of the
  -- current buffer rather than searching every .bib under the cwd, which
  -- naturally scopes it to your LaTeX project's own bibliography.
  --
  -- IMPORTANT: this spec only adds `dependencies` and merges into `opts` —
  -- it deliberately does NOT define its own `config` function. lazy.nvim
  -- merges `opts` tables across multiple specs for the same plugin, but a
  -- second `config` function here would REPLACE kickstart's own
  -- `require('telescope').setup(...)` call (and its fzf/ui-select extension
  -- loading) rather than add to it. Loading the bibtex extension and
  -- setting the tex-only keymap are instead done from a `VeryLazy` autocmd,
  -- the same safe pattern already used for LuaSnip snippets above.
  {
    'nvim-telescope/telescope.nvim',
    optional = true,
    dependencies = {
      'nvim-telescope/telescope-bibtex.nvim',
    },
    opts = function(_, opts)
      opts.extensions = opts.extensions or {}
      opts.extensions.bibtex = {
        -- Per current README (github.com/nvim-telescope/telescope-bibtex.nvim):
        -- `context = true` parses \bibliography{}/\addbibresource{} from the
        -- buffer so the picker only shows entries relevant to the open
        -- LaTeX file rather than every .bib under the cwd.
        context = true,
        context_fallback = true,
        -- 'tex' label format produces \cite{key}; left explicit since this
        -- extension is being scoped to LaTeX use only in this config.
        format = 'tex',
      }
      return opts
    end,
  },

  -- Loads the bibtex extension once Telescope itself is set up, and sets a
  -- tex/plaintex-only keymap. Split out from the spec above so it doesn't
  -- need a `config` function on the telescope.nvim plugin spec itself.
  {
    'nvim-telescope/telescope-bibtex.nvim',
    event = 'VeryLazy',
    config = function()
      local ok = pcall(function()
        require('telescope').load_extension 'bibtex'
      end)
      if not ok then
        return
      end

      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('LatexTelescopeBibtex', { clear = true }),
        pattern = { 'tex', 'plaintex' },
        desc = 'LaTeX-only :Telescope bibtex keymap',
        callback = function(ev)
          vim.keymap.set('n', '<localleader>lb', '<cmd>Telescope bibtex<CR>', {
            buffer = ev.buf,
            desc = 'VimTeX: Insert citation (Telescope bibtex)',
          })
        end,
      })
    end,
  },
}
