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
      {
        "folke/neoconf.nvim",
        cmd = "Neoconf",
        config = true,
        dependencies = { "nvim-lspconfig" },
      },
      { "folke/neodev.nvim", opts = {} },
      {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim", opts = {} },
      },
      "hrsh7th/cmp-nvim-lsp",
    },
    keys = {
      { "<leader>lx", vim.diagnostic.open_float, desc = "Line Diagnostics" },
      { "<leader>lf", vim.lsp.buf.format, desc = "Format whole file" },
      { "<leader>lf", mode = "v", vim.lsp.buf.format, desc = "Format range" },
      {
        "<leader>lh",
        function()
          vim.lsp.inlay_hint(0)
        end,
        desc = "Toggle Inlay Hints",
      },
      {
        "<leader>ld",
        function()
          require("telescope.builtin").lsp_definitions({ reuse_win = true })
        end,
        desc = "Goto Definition",
      },
      {
        "<leader>lr",
        "<cmd>Telescope lsp_references<cr>",
        desc = "References",
      },
      { "<leader>lc", vim.lsp.buf.rename, desc = "Rename" },
      { "<leader>lD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
      {
        "<leader>li",
        function()
          require("telescope.builtin").lsp_implementations({ reuse_win = true })
        end,
        desc = "Goto Implementation",
      },
      {
        "<leader>lt",
        function()
          require("telescope.builtin").lsp_type_definitions({ reuse_win = true })
        end,
        desc = "Goto Type Definition",
      },
      {
        "<leader>la",
        vim.lsp.buf.code_action,
        desc = "Code Action",
        mode = { "n", "v" },
      },
      {
        "<c-k>",
        vim.lsp.buf.signature_help,
        mode = "i",
        desc = "Signature Help",
      },
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
        float = { border = "single", source = "always" },
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "always",
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
        clangd = {
          cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--completion-style=detailed",
            "--function-arg-placeholders",
            "--fallback-style=llvm",
            "--offset-encoding=utf-16",
          },
          init_options = {
            usePlaceholders = true,
            completeUnimported = true,
            clangdFileStatus = true,
          },
        },
        cmake = {},
        cssls = {},
        cssmodules_ls = {},
        docker_compose_language_service = {},
        dockerls = {},
        efm = {},
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
        ocamllsp = { mason = false },
        pyright = {},
        rome = {},
        ruff_lsp = {},
        rust_analyzer = {
          settings = {
            ["rust-analyzer"] = {
              cargo = {
                allFeatures = true,
                loadOutDirsFromCheck = true,
                runBuildScripts = true,
              },
              -- Add clippy lints for Rust.
              checkOnSave = {
                allFeatures = true,
                command = "clippy",
                extraArgs = { "--no-deps" },
              },
              procMacro = {
                enable = true,
                ignored = {
                  ["async-trait"] = { "async_trait" },
                  ["napi-derive"] = { "napi" },
                  ["async-recursion"] = { "async_recursion" },
                },
              },
            },
          },
        },
        semgrep = {},
        taplo = {
          keys = {
            {
              "K",
              function()
                if
                  vim.fn.expand("%:t") == "Cargo.toml"
                  and require("crates").popup_available()
                then
                  require("crates").show_popup()
                else
                  vim.lsp.buf.hover()
                end
              end,
              desc = "Show Crate Documentation",
            },
          },
        },
        solidity_ls_nomicfoundation = {},
        sqlls = {},
        tailwindcss = {},
        texlab = {},
        vimls = {},
        vuels = {},
      },
      setup = {
        clangd = function(_, opts)
          require("clangd_extensions").setup({ server = opts })
          return false
        end,
        rust_analyzer = function(_, opts)
          local ok, mason_registry = pcall(require, "mason-registry")
          local adapter ---@type any
          if ok then
            -- rust tools configuration for debugging support
            local codelldb = mason_registry.get_package("codelldb")
            local extension_path = codelldb:get_install_path() .. "/extension/"
            local codelldb_path = extension_path .. "adapter/codelldb"
            local liblldb_path = vim.fn.has("mac") == 1
                and extension_path .. "lldb/lib/liblldb.dylib"
              or extension_path .. "lldb/lib/liblldb.so"
            adapter = require("rust-tools.dap").get_codelldb_adapter(
              codelldb_path,
              liblldb_path
            )
          end
          require("rust-tools").setup({
            dap = {
              adapter = adapter,
            },
            tools = {
              on_initialized = function()
                vim.cmd([[
                  augroup RustLSP
                  autocmd CursorHold                      *.rs silent! lua vim.lsp.buf.document_highlight()
                  autocmd CursorMoved,InsertEnter         *.rs silent! lua vim.lsp.buf.clear_references()
                  autocmd BufEnter,CursorHold,InsertLeave *.rs silent! lua vim.lsp.codelens.refresh()
                  augroup END
                  ]])
              end,
            },
            server = opts,
          })
          vim.api.nvim_create_autocmd("FileType", {
            pattern = "rust",
            command = [[
                nnoremap <buffer> K <cmd>RustHoverActions<cr>
                nnoremap <buffer> <leader>lg <cmd>RustDebuggables<cr>
                nnoremap <buffer> <leader>lm <cmd>RustRunnables<cr>
              ]],
          })

          return true
        end,
      },
    },
    ---@param opts PluginLspOpts
    config = function(_, opts)
      for name, icon in pairs(diagnostics) do
        name = "DiagnosticSign" .. name
        vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
      end

      if
        type(opts.diagnostics.virtual_text) == "table"
        and opts.diagnostics.virtual_text.prefix == "icons"
      then
        opts.diagnostics.virtual_text.prefix = vim.fn.has("nvim-0.10.0") == 0
            and "●"
          or function(diagnostic)
            for d, icon in pairs(diagnostics) do
              if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
                return icon
              end
            end
          end
      end

      vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

      vim.lsp.handlers["textDocument/signatureHelp"] =
        vim.lsp.with(vim.lsp.handlers.signature_help, {
          border = "single",
        })

      vim.lsp.handlers["textDocument/hover"] =
        vim.lsp.with(vim.lsp.handlers.hover, {
          border = "single",
          silent = true,
        })

      vim.lsp.handlers["textDocument/publishDiagnostics"] =
        vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
          update_in_insert = true,
        })

      local servers = opts.servers
      local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        has_cmp and cmp_nvim_lsp.default_capabilities() or {},
        opts.capabilities or {}
      )

      local lspconfig = require("lspconfig")
      require("lspconfig.configs").fixit = {
        default_config = {
          cmd = { "fixit", "lsp" },
          filetypes = { "python" },
          root_dir = lspconfig.util.root_pattern(
            "pyproject.toml",
            "requirements.txt",
            "setup.py",
            "setup.cfg"
          ) or lspconfig.util.find_git_ancestor,
          single_file_support = true,
        },
      }

      lspconfig.fixit.setup({})

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
        all_mslp_servers = vim.tbl_keys(
          require("mason-lspconfig.mappings.server").lspconfig_to_package
        )
      end

      local ensure_installed = {} ---@type string[]
      for server, server_opts in pairs(servers) do
        if server_opts then
          server_opts = server_opts == true and {} or server_opts
          -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
          if
            server_opts.mason == false
            or not vim.tbl_contains(all_mslp_servers, server)
          then
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
          importModuleSpecifierPreference = "non-relative",
        },
        complete_function_calls = true,
        publish_diagnostic_on = "change",
      },
      on_attach = function(client)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
      end,
    },
  },
  {
    "simrat39/rust-tools.nvim",
    lazy = true,
    dependencies = { "mfussenegger/nvim-dap", "nvim-lua/plenary.nvim" },
  },
  {
    "p00f/clangd_extensions.nvim",
    lazy = true,
    opts = {
      inlay_hints = {
        inline = false,
      },
      ast = {
        --These require codicons (https://github.com/microsoft/vscode-codicons)
        role_icons = {
          type = "",
          declaration = "",
          expression = "",
          specifier = "",
          statement = "",
          ["template argument"] = "",
        },
        kind_icons = {
          Compound = "",
          Recovery = "",
          TranslationUnit = "",
          PackExpansion = "",
          TemplateTypeParm = "",
          TemplateTemplateParm = "",
          TemplateParamObject = "",
        },
      },
    },
  },
}
