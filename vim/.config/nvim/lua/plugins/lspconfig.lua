local diagnostics = {
  Error = " ",
  Warn = " ",
  Hint = " ",
  Info = " ",
}

local function diagnostic_goto(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end

return {
  {
    "llllvvuu/nvim-lspconfig",
    branch = "feat/solidity_ls_nomicfoundation_singlefile",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "folke/neodev.nvim", opts = {} },
      { "williamboman/mason-lspconfig.nvim", dependencies = { "williamboman/mason.nvim", opts = {} } },
      "hrsh7th/cmp-nvim-lsp",
    },
    keys = {
      { "<leader>lx", vim.diagnostic.open_float, desc = "Line Diagnostics" },
      { "<leader>lf", vim.lsp.buf.format, desc = "Format whole file" },
      { "<leader>lf", mode = "v", vim.lsp.buf.format, desc = "Format range" },
      { "<leader>lh", function() vim.lsp.inlay_hint(0) end, desc = "Toggle Inlay Hints" },
      {
        "<leader>ld",
        function() require("telescope.builtin").lsp_definitions({ reuse_win = true }) end,
        desc = "Goto Definition",
      },
      { "<leader>lr", "<cmd>Telescope lsp_references<cr>", desc = "References" },
      { "<leader>lc", vim.lsp.buf.rename, desc = "Rename" },
      { "<leader>lD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
      {
        "<leader>li",
        function() require("telescope.builtin").lsp_implementations({ reuse_win = true }) end,
        desc = "Goto Implementation",
      },
      {
        "<leader>lt",
        function() require("telescope.builtin").lsp_type_definitions({ reuse_win = true }) end,
        desc = "Goto Type Definition",
      },
      {
        "<leader>la",
        vim.lsp.buf.code_action,
        desc = "Code Action",
        mode = { "n", "v" },
      },
      { "<c-k>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help" },
      { "]d", diagnostic_goto(true), desc = "Next Diagnostic" },
      { "[d", diagnostic_goto(false), desc = "Prev Diagnostic" },
      { "]e", diagnostic_goto(true, "ERROR"), desc = "Next Error" },
      { "[e", diagnostic_goto(false, "ERROR"), desc = "Prev Error" },
      { "]w", diagnostic_goto(true, "WARN"), desc = "Next Warning" },
      { "[w", diagnostic_goto(false, "WARN"), desc = "Prev Warning" },
    },
    ---@class PluginLspOpts
    opts = {
      diagnostics = {
        float = { border = "single" },
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "icons",
        },
        severity_sort = true,
      },
      inlay_hints = {
        enabled = true,
      },
      capabilities = {
        textDocument = {
          foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
          },
        },
      },
      ---@type lspconfig.options
      servers = {
        bashls = {
          on_attach = function(client)
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
          end,
        },
        bufls = {}, -- Protobuf
        clangd = {},
        cssls = {},
        cssmodules_ls = {},
        docker_compose_language_service = {},
        dockerls = {},
        efm = {
          init_options = {
            documentFormatting = true,
            documentRangeFormatting = true,
          },
        },
        eslint = {},
        gopls = {},
        graphql = {},
        hls = {}, -- Haskell
        html = {},
        lua_ls = {
          on_attach = function(client)
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
          end,
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        },
        jsonls = {},
        marksman = {},
        mm0_ls = {},
        pylsp = {
          settings = {
            pylsp = {
              configurationSources = { "mypy", "ruff", "black", "rope_autoimport" },
              plugins = {
                jedi_completion = {
                  enabled = true,
                  eager = true,
                  cache_for = { "numpy", "scipy", "matplotlib" },
                },
                jedi_definition = {
                  enabled = true,
                  follow_imports = true,
                  follow_builtin_imports = true,
                },
                jedi_hover = { enabled = true },
                jedi_references = { enabled = true },
                jedi_signature_help = { enabled = true },
                jedi_symbols = { enabled = true, all_scopes = true, include_import_symbols = true },
                preload = { enabled = true, modules = { "numpy", "scipy", "matplotlib" } },
                black = { enabled = true },
                ruff = { enabled = true },
                mypy = { enabled = true },
                rope_autoimport = { enabled = true },
                autopep8 = { enabled = false },
                yapf = { enabled = false },
                pycodestyle = { enabled = false, ignore = {} },
                pyflakes = { enabled = false },
                isort = { enabled = false },
                flake8 = { enabled = false },
                mccabe = { enabled = false },
                pylint = { enabled = false },
                rope_completion = { enabled = false },
                pydocstyle = { enabled = false },
              },
            },
          },
        },
        rust_analyzer = {},
        solidity_ls_nomicfoundation = {},
        sqlls = {},
        tailwindcss = {},
        texlab = {},
        vimls = {},
        vuels = {},
      },
      setup = {},
    },
    ---@param opts PluginLspOpts
    config = function(_, opts)
      for name, icon in pairs(diagnostics) do
        name = "DiagnosticSign" .. name
        vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
      end

      local inlay_hint = vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint

      if opts.inlay_hints.enabled and inlay_hint then
        vim.api.nvim_create_autocmd("LspAttach", {
          callback = function(args)
            local buffer = args.buf
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if client.server_capabilities.inlayHintProvider then
              inlay_hint(buffer, true)
            end
          end,
        })
      end

      if type(opts.diagnostics.virtual_text) == "table" and opts.diagnostics.virtual_text.prefix == "icons" then
        opts.diagnostics.virtual_text.prefix = vim.fn.has("nvim-0.10.0") == 0 and "●"
          or function(diagnostic)
            for d, icon in pairs(diagnostics) do
              if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
                return icon
              end
            end
          end
      end

      vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
        vim.lsp.handlers.signature_help, {
          border = "single",
        }
      )

      vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
        vim.lsp.handlers.hover, {
          border = "single",
          silent = true,
        }
      )

      local servers = opts.servers
      local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        has_cmp and cmp_nvim_lsp.default_capabilities() or {},
        opts.capabilities or {}
      )

      local function setup(server)
        local server_opts = vim.tbl_deep_extend("force", {
          capabilities = vim.deepcopy(capabilities),
        }, servers[server] or {})

        if opts.setup[server] then
          if opts.setup[server](server, server_opts) then
            return
          end
        elseif opts.setup["*"] then
          if opts.setup["*"](server, server_opts) then
            return
          end
        end
        require("lspconfig")[server].setup(server_opts)
      end

      -- get all the servers that are available thourgh mason-lspconfig
      local have_mason, mlsp = pcall(require, "mason-lspconfig")
      local all_mslp_servers = {}
      if have_mason then
        all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
      end

      local ensure_installed = {} ---@type string[]
      for server, server_opts in pairs(servers) do
        if server_opts then
          server_opts = server_opts == true and {} or server_opts
          -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
          if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
            setup(server)
          else
            ensure_installed[#ensure_installed + 1] = server
          end
        end
      end

      if have_mason then
        mlsp.setup({ ensure_installed = ensure_installed, handlers = { setup } })
      end
    end,
  },
  -- {
  --   'llllvvuu/efmls-configs-nvim',
  --   branch = 'dev',
  --   dependencies = { 'nvim-lspconfig' },
  --   event = { "BufReadPre", "BufNewFile" },
  --   config = function ()
  --     local efmls = require('efmls-configs')
  --     efmls.init {
  --       init_options = {
  --         documentFormatting = true,
  --         documentRangeFormatting = true,
  --       },
  --     }
  --
  --     local prettierd = require('efmls-configs.formatters.prettier_d')
  --     efmls.setup({
  --       javascript = {
  --         formatter = prettierd,
  --       },
  --       typescript = {
  --         formatter = prettierd,
  --       },
  --       javascriptreact = {
  --         formatter = prettierd,
  --       },
  --       typescriptreact = {
  --         formatter = prettierd,
  --       },
  --       solidity = {
  --         formatter= require('efmls-configs.formatters.forge_fmt'),
  --         linter = {
  --           require('efmls-configs.linters.solhint'),
  --           require('efmls-configs.linters.slither'),
  --         }
  --       },
  --       lua = {
  --         linter = require('efmls-configs.linters.luacheck'),
  --         formatter = require('efmls-configs.formatters.stylua'),
  --       },
  --       sh = {
  --         linter = require('efmls-configs.linters.shellcheck'),
  --         formatter = require('efmls-configs.formatters.shfmt'),
  --       }
  --     })
  --   end
  -- },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-lspconfig" },
    opts = {
      settings = {
        tsserver_file_preferences = {
          includeInlayParameterNameHints = "all",
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
          importModuleSpecifierPreference = 'non-relative',
        },
        vscode_configuration = {
          ["typescript.suggest.completeFunctionCalls"] = true,
        },
      },
      on_attach = function(client)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
      end,
    }
  }
}
