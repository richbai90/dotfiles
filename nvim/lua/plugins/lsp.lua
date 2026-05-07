return {
  {
    'mason-org/mason.nvim',
    opts = {},
  },
  {
    'mason-org/mason-lspconfig.nvim',
    ensure_installed = {
      'lua_ls',
      'basedpyright',
      'ts_ls',
      'matlab_ls',
      'harper_ls',
    }
  },
  {
    'neovim/nvim-lspconfig',
    config = function()
      local on_attach = function(client, bufnr)
        vim.keymap.set('n', '<LocalLeader>d', vim.diagnostic.open_float,
          { buffer = bufnr, desc = "Show line diagnostics" })
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr, desc = "Show hover information" })
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = bufnr, desc = "Go to declaration" })
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to definition" })
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { buffer = bufnr, desc = "Go to implementation" })
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = bufnr, desc = "Show references" })
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename" })
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code action" })
      end

      local servers = { 'lua_ls', 'basedpyright', 'ts_ls', 'matlab_ls', 'harper_ls', 'ccls' }

    for _, lsp in ipairs(servers) do
      vim.lsp.config(lsp, {
        on_attach = on_attach,
      })
      vim.lsp.enable(lsp)
    end

      vim.lsp.config('pyright', {
        on_attach = on_attach,
          root_markers = {
            'uv.lock',
            'pyrightconfig.json',
            'pyproject.toml',
            'setup.py',
            'setup.cfg',
            'requirements.txt',
            'Pipfile',
            '.git',
          },
        settings = {
            python = {
              analysis = {
                autoSearchPaths = true,
                diagnosticMode = 'workspace',
              },
            },
          },
      })

      vim.lsp.config('matlab_ls', {
        on_attach = on_attach,
        settings = {
          matlab = {
            installPath = '/opt/MATLAB/R2024b',
            telemetry = false,
          },
        },
      })
      vim.lsp.config("ccls", {
        on_attach = on_attach,
        init_options = {
          index = {
            threads = 16,
          },
          clang = {
            excludeArgs = { "-frounding-math" },
          },
        }
      })
      vim.lsp.config('harper_ls', {
        on_attach = on_attach,
linters = {
        spell_check = true,
        spelled_numbers = true,
        an_a = true,               -- Fixes "a apple" -> "an apple"
        sentence_capitalization = true,
        unclosed_quotes = true,
        wrong_quotes = true,
        long_sentences = true,     -- Style suggestion
        repeated_words = true,
        spaces = true,
        matcher = true,            -- Enables the rule-based grammar matcher
      },
        filetypes = {
          "markdown", 
          "tex",           -- This enables LaTeX support
          "plaintex", 
  "asciidoc", "c", "cpp", "cs", "gitcommit", "go", "html", "java", "javascript", "lua", "markdown", "nix", "python", "ruby", "rust", "swift", "toml", "typescript", "typescriptreact", "haskell", "cmake", "typst", "php", "dart", "clojure", "sh" }
      })

    end
  },
  {
    'mrcjkb/rustaceanvim',
    version = '^6', -- Recommended
    lazy = false,   -- This plugin is already lazy
    config = function()
      vim.g.rustaceanvim = {
        server = {
          on_attach = function(client, bufnr)
            vim.notify("Attaching to Rust", "info")
            vim.keymap.set('n', '<LocalLeader>d', function() vim.cmd.RustLsp({ 'renderDiagnostic', 'current' }) end,
              { buffer = bufnr, desc = "Show line diagnostics" })
            vim.keymap.set('n', '<LocalLeader>K', function() vim.cmd.RustLsp({ 'hover', 'actions' }) end,
              { buffer = bufnr, desc = "Show hover information" })
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = bufnr, desc = "Go to declaration" })
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to definition" })
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { buffer = bufnr, desc = "Go to implementation" })
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = bufnr, desc = "Show references" })
            vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename" })
            vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code action" })
          end
        }
      }
    end
  },
  -- FORMATTING WITH CONFORM --
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        -- Customize or remove this keymap to your liking
        "<leader>F",
        function()
          require("conform").format({ async = true })
        end,
        mode = "",
        desc = "Format buffer",
      },
    },
    -- This will provide type hinting with LuaLS
    ---@module "conform"
    ---@type conform.setupOpts
    opts = {
      -- Define your formatters
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "isort", "black" },
        javascript = { "prettierd", "prettier", stop_after_first = true },
      },
      -- Set default options
      default_format_opts = {
        lsp_format = "fallback",
      },
      -- Set up format-on-save
      format_on_save = { timeout_ms = 500 },
      -- Customize formatters
      formatters = {
        shfmt = {
          append_args = { "-i", "2" },
        },
      },
    },
    init = function()
      -- If you want the formatexpr, here is the place to set it
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
  }
}
