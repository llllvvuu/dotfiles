local diagnostics =
  { Error = " ", Warn = " ", Hint = " ", Info = " " }

local function diagnostic_goto(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end

vim.lsp.commands["editor.action.showReferences"] = function(command, ctx)
  local locations = command.arguments[3]
  local client = vim.lsp.get_client_by_id(ctx.client_id)
  if locations and #locations > 0 then
    local items =
      vim.lsp.util.locations_to_items(locations, client.offset_encoding)
    vim.fn.setloclist(
      0,
      {},
      " ",
      { title = "References", items = items, context = ctx }
    )
    vim.api.nvim_command("lopen")
  end
end

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client.server_capabilities.codeLensProvider then
      vim.api.nvim_create_autocmd(
        { "CursorHold", "CursorHoldI" },
        { callback = vim.lsp.codelens.refresh, buffer = args.buf }
      )
    end
  end,
})

return {
  {
    "llllvvuu/nvim-lspconfig",
    branch = "feat/solidity_ls",
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
      {
        "<leader>lh",
        function()
          vim.lsp.inlay_hint(0)
        end,
        desc = "Toggle Inlay Hints",
      },
      {
        "gd",
        function()
          require("telescope.builtin").lsp_definitions({ reuse_win = true })
        end,
        desc = "Goto Definition",
      },
      {
        "<leader>s",
        function()
          require("telescope.builtin").lsp_document_symbols({ reuse_win = true })
        end,
        desc = "LSP Document Symbols",
      },
      {
        "gr",
        "<cmd>Telescope lsp_references<cr>",
        desc = "References",
      },
      { "<leader>r", vim.lsp.buf.rename, desc = "Rename" },
      { "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
      {
        "gi",
        function()
          require("telescope.builtin").lsp_implementations({ reuse_win = true })
        end,
        desc = "Goto Implementation",
      },
      {
        "gy",
        function()
          require("telescope.builtin").lsp_type_definitions({ reuse_win = true })
        end,
        desc = "Goto Type Definition",
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
        biome = {},
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
            client.server_capabilities.documentOnTypeFormattingProvider = nil
          end,
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              completion = {
                callSnippet = "Replace",
              },
              format = {
                enabled = true,
                defaultConfig = {
                  indent_style = "space",
                  indent_size = 2,
                  continuation_indent = 2,
                },
              },
            },
          },
        },
        jsonls = {},
        marksman = {},
        mm0_ls = {},
        ocamllsp = { mason = false },
        pyright = {},
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
        -- semgrep = {},
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
        solidity_ls = {},
        sqlls = {},
        tailwindcss = {},
        texlab = {},
        vimls = {},
        vtsls = {
          settings = {
            vtsls = {
              experimental = {
                completion = {
                  enableServerSideFuzzyMatch = true,
                },
              },
            },
            typescript = {
              inlayHints = {
                parameterNames = { enabled = "literals" },
                parameterTypes = { enabled = true },
                variableTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                enumMemberValues = { enabled = true },
              },
              referencesCodeLens = { enabled = true },
              format = { enable = false },
              suggest = {
                completeFunctionCalls = { enabled = true },
              },
              preferGoToSourceDefinition = true,
            },
            javascript = {
              preferGoToSourceDefinition = true,
              referencesCodeLens = { enabled = true },
              inlayHints = {
                parameterNames = { enabled = "literals" },
                parameterTypes = { enabled = true },
                variableTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                enumMemberValues = { enabled = true },
              },
            },
            ["js/ts"] = {
              implicitProjectConfig = {
                checkJs = true,
                compilerOptions = {
                  module = "esnext",
                  target = "esnext",
                },
              },
            },
          },
        },
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

      -- get all the servers that are available through mason-lspconfig
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
