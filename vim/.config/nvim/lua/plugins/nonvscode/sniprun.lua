--- @diagnostic disable: missing-fields

--- @type LazyPluginSpec
return {
  "michaelb/sniprun",
  enabled = function()
    return vim.fn.executable("cargo") == 1
  end,
  build = "sh install.sh",
  cmd = { "SnipRun" },
  keys = {
    { "<leader>5", "<Plug>SnipRun", mode = { "n", "x" }, desc = "SnipRun" },
    {
      "<leader>4",
      function()
        require("sniprun.display").close_all()
        require("sniprun").reset()
      end,
      mode = { "n", "x" },
      desc = "Close SnipRun",
    },
    {
      "<leader>6",
      function()
        require("sniprun.display").clear_virtual_text()
      end,
      mode = { "n", "x" },
      desc = "Clear SnipRun Virtual Text",
    },
  },
  opts = {
    selected_interpreters = {
      "Python3_fifo",
      "Haskell",
      "Bash_original",
      "C_original",
      "Cpp_original",
      "Lua_nvim",
      "Rust_original",
      "JS_TS_deno",
    },
    repl_enable = {
      "Python3_fifo",
      "Lua_nvim",
      "JS_TS_deno",
    },
    display = {
      "VirtualTextOk",
      "LongTempFloatingWindow",
      "TerminalWithCode",
    },
  },
}
