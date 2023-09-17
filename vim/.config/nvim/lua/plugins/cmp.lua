return {
  {
    "llllvvuu/nvim-cmp",
    branch = "feat/above",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      { "wookayin/cmp-omni", branch = "fix-return" },
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      { "Saecki/crates.nvim", event = { "BufRead Cargo.toml" }, config = true },
      "clangd_extensions.nvim",
    },
    opts = function()
      vim.api.nvim_set_hl(
        0,
        "CmpGhostText",
        { link = "Comment", default = true }
      )
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local defaults = require("cmp.config.default")()
      table.insert(defaults.sorting, require("clangd_extensions.cmp_scores"))
      return {
        autocomplete = {
          cmp.TriggerEvent.InsertEnter,
          cmp.TriggerEvent.TextChanged,
        },
        keyword_length = 0,
        completion = {
          completeopt = "menu,preview,menuone,noselect",
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = false }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          {
            name = "omni",
            option = {
              disable_omnifuncs = { "v:lua.vim.lsp.omnifunc" },
            },
          },
          { name = "luasnip" },
          { name = "crates" },
          { name = "buffer" },
          { name = "path" },
        }),
        sorting = defaults.sorting,
        view = {
          entries = {
            selection_order = "near_cursor",
            vertical_positioning = "above",
          },
        },
        window = {
          completion = { -- thin-style scrollbar
            border = "single",
            scrollbar = "║",
          },
          documentation = {
            border = "single",
            scrollbar = "║",
          },
        },
      }
    end,
  },
}
